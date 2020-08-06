%% CRV_26_ExistenceOfObstacles
% name: Pilar Navarro Ramirez
% student number: 3086150
%% clean up
clear all;
close all;
clc;

%% Select sequence
imgSeqDir = ['sequences', filesep, '1', filesep];
imgSeqN = length(dir(imgSeqDir))-2;

%% ComputerVisionToolbox
% Check if computer vision toolbox (CVTB) is available
has_CVTB = license('test','video_and_image_blockset');

% If CVTB is not available load workspace file containing correspondences
if ~has_CVTB
    load('corresPoints.mat');
end

%% Image sequence analysis

f = figure();

for k=1:imgSeqN
    % Load image
    I = rgb2gray(imread([imgSeqDir,'image_',int2str(k),'.png']));
    
    % Show image
    figure(f)
    imshow(I);
    hold on;
    
    % Iteration of eight tiles
    for t=1:8
        
        % Define the ROI/tile coordinates and draw it
        roiP = [128*(t-1)+1,128*5,128,128*2];
        imrect(gca, roiP);
        
        if has_CVTB
            % Detect salient points in ROI and extract features
            ptsCurr = detectSURFFeatures(I,'ROI',roiP, 'MetricThreshold',1 );
            [tiles(t).featuresCurr,tiles(t).validPtsCurr] = ...
                extractFeatures(I,ptsCurr);
        end
        
        
        if k>1
            if has_CVTB
                % Match features of previous and current image
                [indexPairs,matchmetric] = matchFeatures(tiles(t).featuresPrev,tiles(t).featuresCurr,'Unique',true);
                
                % Extract coordinates of corresponding points
                matchedPrev = tiles(t).validPtsPrev(indexPairs(:,1));
                matchedCurr = tiles(t).validPtsCurr(indexPairs(:,2));
                
                % Save coordinates in lecture notation
                X = matchedPrev.Location(:,1);
                Y = matchedPrev.Location(:,2);
                XPrime = matchedCurr.Location(:,1);
                YPrime = matchedCurr.Location(:,2);
                
            else
                % Save coordinates in lecture notation
                X = correspondences(k-1,t).X;
                Y = correspondences(k-1,t).Y;
                XPrime = correspondences(k-1,t).XPrime;
                YPrime = correspondences(k-1,t).YPrime;
            end
            
            % Plot points in current image, which have a match withb
            % salient point from previous image
            plot(XPrime,YPrime,'y.','MarkerSize',10); 
            
            %%%MY_CODE
            
            L=length(X);
            
            if(L>=4)
                M_cor=zeros(2*L,8);
                M_nex=zeros(2*L,1);

                for i=1:L
                    M_cor(2*i-1,:)=[X(i) Y(i) 1 0 0 0 -X(i)*XPrime(i) -Y(i)*XPrime(i)];
                    M_cor(2*i,:)=[0 0 0 X(i) Y(i) 1 -X(i)*YPrime(i) -Y(i)*YPrime(i)];
                    M_nex(2*i-1,1)=XPrime(i);
                    M_nex(2*i,1)=YPrime(i);
                end

                M_cn=[M_cor M_nex];

                s_cor = svd(M_cor);           
                s_cn = svd(M_cn);

                threshold=10;

                ns_cor=0;
                ns_cn=0;
                for i=1:length(s_cor)
                    if s_cor(i)>threshold
                        ns_cor=ns_cor+1;
                    end
                end
                
                for i=1:length(s_cn)
                    if s_cn(i)>threshold
                        ns_cn=ns_cn+1;
                    end
                end
              

                if ns_cor==ns_cn
                    plot(XPrime,YPrime,'g.','MarkerSize',10);
                else
                    plot(XPrime,YPrime,'r.','MarkerSize',10);
                end
            end
            %%%
            
        end
        
        if has_CVTB
            % Prepare next iteration
            tiles(t).featuresPrev = tiles(t).featuresCurr;
            tiles(t).validPtsPrev = tiles(t).validPtsCurr;
        end
        
    end
    hold off;
    drawnow;
    pause(0.001);
end