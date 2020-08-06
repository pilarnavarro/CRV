%% CRV_17
% name:Pilar Navarro Ramirez
% student number: 3086150

%% clean up
clear all;
close all;
clc;

%% Load camera parameters
load('WScameraparameters.mat')

%% Read the image

filename = uigetfile('*.*', 'Select the image'); 
rgb = imread(filename);
% figure; imshow(rgb);
% title('Input Image');

%% Rectify image

[im, ~] = undistortImage(rgb, cameraParams, 'OutputView', 'full');
% figure; imshow(im);
% title('Undistorted Image');

%% Extract extrinsic for specific position

% Detect the checkerboard.
[imagePoints, boardSize] = detectCheckerboardPoints(im);
% Compute rotation and translation of the camera.
[R, t] = extrinsics(imagePoints, cameraParams.WorldPoints, cameraParams);

%% Detect coins
I= rgb2gray(im);
I= imgaussfilt(I,1.5);
BW=edge(I,'Sobel');
[centersCoins, radiiCoins] = imfindcircles(BW,[10,200],'ObjectPolarity','dark','Sensitivity',0.8);

numCoins = size(radiiCoins);
n=numCoins(1);

%% Get the diameter 
imagePoints=zeros(2*n+1,2);
for i=1:n
    imagePoints(i,1)=centersCoins(i,1)-radiiCoins(i);
    imagePoints(i,2)=centersCoins(i,2);
    
    imagePoints(2*n-i+1,1)=centersCoins(i,1)+radiiCoins(i);
    imagePoints(2*n-i+1,2)=centersCoins(i,2);
end

worldPoints = pointsToWorld(cameraParams, R, t, imagePoints);

d=zeros(n,1);
for i=1:n
     d(i,1)=sqrt(sum((worldPoints(i,:)-worldPoints(2*n-i+1,:)).^2));
end

%% Coin clasifier
num1=length(d(d>14.5 & d<17.5));
num10=length(d(d>17.5 & d<21.5));
num50=length(d(d>21.5 & d<28));

%% Show result 
figure;
imshow(im);
hold on;
viscircles(centersCoins, radiiCoins,'EdgeColor','g');

title(sprintf('%d x 1 Eurocent(s),%d x 10 Eurocent(s),%d x 50 Eurocent(s)',num1,num10,num50),'FontSize',14);

