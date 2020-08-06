%% CRV_24_ImageSequenceAnalysisKalman
% name: Pilar Navarro Ramirez
% student number: 3086150
%% clean up
clear all;
close all;
clc;

%% Select sequence
imgSeqDir = ['robWall', filesep];
imgSeqN = length(dir(imgSeqDir))-2;

%% Create matrix for measurements
m = zeros(2,imgSeqN);

%% Load pattern
pattern = imread('pattern.png');
[mPattern,nPattern] = size(pattern);

%% Process image sequence
f = figure();
for k= 1:imgSeqN
    % Load image
    I = rgb2gray(imread([imgSeqDir,'image_',int2str(k),'.png']));
    
    % Pattern matching and measurements
    c = normxcorr2(pattern,I);
    [ypeak, xpeak] = find(c==max(c(:)));
    m(:,k) = ([xpeak, ypeak] - [mPattern,nPattern]/2)';
    
    
    % Visualization
    figure(f);
    imshow(I);
    hold on;
    plot(m(1,k),m(2,k),'rx','MarkerSize',15,'LineWidth',3);
    hold off;
    title(['Max. correlation: ',num2str(c(ypeak, xpeak))]);
    drawnow;
    pause(0.001);
end
close(f);
%% Initialization 
Threshold=0.58368;
Pi=[1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];
H=[1 0 0 0; 0 1 0 0];
Q=10^(-6)*[70 1 1 1; 1 70 1 1; 1 1 70 1; 1 1 1 70];
Ck=10^(-6)*[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
sk=[1470 700 0 0]';
estimations=zeros(2,imgSeqN-1);
%% Kalman Filter
for k= 2:imgSeqN
    % Load image
    I = rgb2gray(imread([imgSeqDir,'image_',int2str(k),'.png']));
    
    % Pattern matching and measurements
    c = normxcorr2(pattern,I);
    [ypeak, xpeak] = find(c==max(c(:)));
    m(:,k) = ([xpeak, ypeak] - [mPattern,nPattern]/2)';
    
 % Measurement noise covariance matrix
    if c(ypeak, xpeak)>=Threshold
        R=10^(-3)*[500 1; 1 500];
    else
        R=10^(-3)*[50000 1; 1 50000];
    end
    
    % Kalman filter   
    Ck_prime=Pi*Ck*(Pi)'+Q;
    G=Ck_prime*(H')*(inv(H*Ck_prime*(H')+R));
    I=eye(4);
    Ck=(I-G*H)*Ck_prime*(I-G*H)'+G*R*G';
    sk_prime=Pi*sk;
    sk=sk_prime+G*(m(:,k)-H*Pi*sk); 
    estimations(1,k-1)= sk(1);
    estimations(2,k-1)= sk(2);
   
end

 
    %% Visualization
    I = rgb2gray(imread([imgSeqDir,'image_60','.png']));
    figure();
    imshow(I);
    hold on;
    plot(m(1,2:end),m(2,2:end),'rx',estimations(1,:),estimations(2,:),'bx');
    legend('Measurements','Estimations')
    hold off;
    
%If the initial state estimation is far from the real state, the state estimations
%that we obtain in the following images are not correct. But if the
%initial estimation is accurate, then the following estimated states are
%quite reliable. Moreover, if the noise described by the covariance
%matrices is lower, the state estimations are more accurate too. 
