%% CRV_25_ImageSequenceAnalysisKalmanBuildIn
% name: John Doe
% student number: 11235813

%% clean up
clear all;
close all;
clc;

%% Select sequence
imgSeqDir = ['robWall', filesep];
imgSeqN = length(dir(imgSeqDir))-2;

%% Parameters

% Define ROI size
roiWidth = 600;
roiHeight = 600;

% Define Kalman Filter parameters
MotionModel = 'ConstantVelocity';
InitialEstimateError = [1 1]*1e3;
MotionNoise = [25, 10];
MeasurementNoise = 5e4;

% Displacement boundaries
minDisp = 5;
maxDisp = 80;

%% Load first image

I_Prev = rgb2gray(imread([imgSeqDir,'image_1.png']));
[mI, nI] = size(I_Prev);

%% Initial POI for first image

f = figure();
imshow(I_Prev);
str = 'Click to select initial POI. Double-click to confirm and proceed.';
title(str,'Color','b','FontSize',12);
poiH = impoint();
initialLocation = wait(poiH);
close(f);

%% Initialialize matrices

% Matrix to save the measurements
m = zeros(2,imgSeqN);
m(:,1) = initialLocation; 
sEst = m; % Matrix to save the estimated locations
sPrime = m; % Matrix to save the predicted locations

%% Initial features

% Set ROI of given width and height (see parameters) centered around
% initial location
roiP = boundedROI(initialLocation,roiWidth,roiHeight,mI,nI);

% Detect salient points in ROI and extract features
ptsPrev = detectHarrisFeatures(I_Prev,'ROI', roiP);
[featuresPrev,validPtsPrev] = extractFeatures(I_Prev,ptsPrev);

%% Initialize Kalman Filter

kalmanFilter = configureKalmanFilter(MotionModel, initialLocation, InitialEstimateError, MotionNoise, MeasurementNoise);

%% Image sequence analysis

f = figure();

for k=2:imgSeqN
    % Load image
    I_Curr = rgb2gray(imread([imgSeqDir,'image_',int2str(k),'.png']));
    
    % Predict new position using the Kalman Filter
    sPrime(:,k) = predict(kalmanFilter);
    
    % If the predicted position is outside of the image the algorithm stops
    if (min(sPrime(:,k))<1)||(sPrime(1,k)>mI)||(sPrime(2,k)>nI)
        break;
    end
    
    % Define new ROI of given width and height (see parameters) centered
    % around predicted position sPrime(:,k)
    roiP = boundedROI(sPrime(:,k),roiWidth,roiHeight,mI,nI);
    
    % Detect salient points in ROI and extract features
    ptsCurr = detectHarrisFeatures(I_Curr,'ROI',roiP);
    [featuresCurr,validPtsCurr] = ...
        extractFeatures(I_Curr,ptsCurr);
    
    % Match features of previous and current image
    [indexPairs,matchmetric] = matchFeatures(featuresPrev,featuresCurr);
    matchedPrev  = validPtsPrev(indexPairs(:,1));
    matchedCurr = validPtsCurr(indexPairs(:,2));
    
    % Discriminate matched pair of points based on the distance. Just
    % pairs with a distance/displacement in between minDisp and minDisp are
    % considered to be located on the moving object
    dist = matchedCurr.Location - matchedPrev.Location;
    objPtsInd = (sqrt(sum(dist.^2,2)) >= minDisp) & (sqrt(sum(dist.^2,2)) <= maxDisp);
    
    figure(f)
    
    % If points are classified to belong to the object to track
    if any(objPtsInd) 
        objPtsPrev = matchedPrev(objPtsInd,:);
        objPtsCurr = matchedCurr(objPtsInd,:);
        % 'Measure' by taking the average of the coordinates of the matched
        % points
        m(:,k) = mean(objPtsCurr.Location,1)'; 

        % Correct prediction based on the measurements
        sEst(:,k) = correct(kalmanFilter, m(:,k));
        
        % Visualize matched points and previous and current image
        showMatchedFeatures(I_Prev,I_Curr,objPtsPrev,objPtsCurr);
        legendText = {'Matched points (prev)','Matched points (curr)',...
            'Displacement','Measurements','Predictions','Estimations'};
    else
        % If no matched points have been classified to belong to the object
        % jsut show the current image
        imshow(I_Curr);
        legendText = {'Measurements','Predictions','Estimations'};
    end
    
    % Visualizations
    hold on;
    % Visualize current ROI
    imrect(gca, roiP);
    % Plot measurement, predictions and estimations
    plot(m(1,1:k),m(2,1:k),'rx','MarkerSize',15,'LineWidth',3);
    plot(sPrime(1,1:k),sPrime(2,1:k),'g.','MarkerSize',15,'LineWidth',3);
    plot(sEst(1,1:k),sEst(2,1:k),'bx','MarkerSize',15,'LineWidth',3);
    hold off;
    
    % Title and legend
    title('Image sequence analysis using Kalman Filter')
    legend(legendText);
    drawnow;
    pause(0.001);
    
    % Prepare next iteration
    I_Prev = I_Curr;
    featuresPrev = featuresCurr;
    validPtsPrev = validPtsCurr;
end

% Visualizing results with parameter set described in title
digits(6);
iniEstErr = latex(sym(InitialEstimateError,'d'));
MotNois = latex(sym(MotionNoise,'d'));
figure(f)
imshow(I_Curr)
hold on;
plot(m(1,1:k),m(2,1:k),'r.','MarkerSize',15,'LineWidth',3);
plot(sPrime(1,1:k),sPrime(2,1:k),'g.','MarkerSize',15,'LineWidth',3);
plot(sEst(1,1:k),sEst(2,1:k),'b.','MarkerSize',15,'LineWidth',3);
hold off;
title(['ROI: ', int2str(roiWidth), 'x', int2str(roiHeight), ', ',...
    MotionModel, ', ',...
    'IniEstErr: $', iniEstErr, '$', ', ',...
    'MotNoise: $', MotNois, '$', ', ',...
    'MeasNoise: ', num2str(MeasurementNoise)],...
    'Interpreter', 'latex');
legend('Measurements','Predictions','Estimations');
set(gca, 'Units','normalized', 'Position',[0.05 0.05 0.9 0.9]);


% Helper function the restrict the size of the ROI
function [roiP] = boundedROI(centerPos,roiWidth,roiHeight,mI,nI)
    roiP = [centerPos(1)-roiWidth/2,centerPos(2)-roiHeight/2,roiWidth,roiHeight];
    if roiP(1) < 1
        roiP(3) = roiP(1)+roiP(3);
        roiP(1) = 1;
    end
    if roiP(2) < 1
        roiP(4) = roiP(2)+roiP(4);
        roiP(2) = 1;
    end
    if (roiP(1)+roiP(3)) > mI
        roiP(3) = mI - roiP(1);
    end
    if (roiP(2)+roiP(4)) > nI
        roiP(4) = nI - roiP(2);
    end
end
