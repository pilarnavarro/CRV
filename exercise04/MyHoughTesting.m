%% MyHoughTesting

%% Init
clear all;
close all;
clc;

%% Create edge image
edgeImage = zeros(100); 
edgeImage(30,:) = round(rand(100,1)); 
edgeImage(60,:) = round(rand(100,1)); 

%% Hough transform
[accu, h, alpha] = MyHough(edgeImage);

%% Visualization
figure();
subplot(131);
imshow(edgeImage);
title('edge image');
subplot(132);
imshow(accu,[]); % ,[] enables automatic scaling
axis square;
title('hough image');
subplot(133);
imshow(log(1+accu),[]);
axis square;
title('hough image (logarithmic scale)');