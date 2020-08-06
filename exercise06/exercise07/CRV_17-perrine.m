%% CRV_17
% name: Perrine Solt
% student number: 3086215

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



%% Detection of circles

% Show the image
%figure; imshow(im);
im=imgaussfilt(im,2);
[centers, radii, metric] = imfindcircles(im,[30 90],'ObjectPolarity','dark');
%viscircles(centers, radii,'EdgeColor','b');
%viscircles([1000 1000], 50);

centers

[n,m]=size(centers);
imagePoints=zeros(2*n+1,2);
for i=1:n
    imagePoints(i,1)=centers(i,1)-radii(i);
    imagePoints(i,2)=centers(i,2);
    imagePoints(2*n-i+1,1)=centers(i,1)+radii(i);
    imagePoints(2*n-i+1,2)=centers(i,2);
end

imagePoints


distance=zeros(n,1);
worldPoints = pointsToWorld(cameraParams, R, t, imagePoints);
worldPoints
n
for i=1:n
%     d = (worldPoints(2*n-i+1,2)-worldPoints(i,2))/(worldPoints(2*n-i+1,1)-worldPoints(i,1));
%      distance(i,1)=worldPoints(2*n-i+1,2)-worldPoints(i,1);
     distance(i,1)=sqrt(sum((worldPoints(i,:)-worldPoints(2*n-i+1,:)).^2));
end


distance

count_1=0;
count_10=0;
count_50=0;

for i=1:n
    if (distance(i,1)>14.5) && (distance(i,1)<=17.5)
        count_1=count_1+1;
   
    elseif (distance(i,1)>17.5) && (distance(i,1)<=21.5)
            count_10 = count_10 + 1;
    elseif (distance(i,1)>21.5) && (distance(i,1)<=28)
    count_50 = count_50 + 1;
    end
    
end

count_1
count_10
count_50
    
figure; imshow(im);
viscircles(centers, radii,'EdgeColor','b');
title(sprintf('%1.0f x 1 Eurocent(s), %1.0f x 10 Eurocent(s), %1.0f x 50 Eurocent(s)', count_1, count_10, count_50),'FontSize',14);

%% Helper functions

% function [] = updateTitle(cameraParams, R, t, imagePoints)
% worldPoints = pointsToWorld(cameraParams, R, t, imagePoints);
% d = sqrt(sum((worldPoints(1,:)-worldPoints(2,:)).^2));
% title(sprintf('distance: %1.0f mm',d),'FontSize',14);
% end
% 



% [n,m]=size(centers);
% imagePoints=zeros(n,4);
% for i=1:n
%     imagePoints(i,1)=centers(i,1)-radii(i),
%     imagePoints(i,2)=centers(i,2)-radii(i),
%     imagePoints(i,3)=centers(i,1)+radii(i),
%     imagePoints(i,4)=centers(i,2)+radii(i),
% end
% 
% distance=zeros(n,1);
% for i=1:n
%     worldPoints = pointsToWorld(cameraParams, R, t, imagePoints);
%     d = (worldPoints(i,4)-worldPoints(i,2))/(worldPoints(i,3)-worldPoints(i,1));
%     distance(i,1)=d;
% end

