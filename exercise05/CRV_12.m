%% CRV_12_activecontour
% name : Pilar Navarro Ramírez
% student number : 3086150
%% clean up
clear all;
close all;
clc;
%% Star
I1=imread('ac01-star.png');
I1=imgaussfilt(I1,1);
figure;
imshow(I1);
mask1=roipoly(I1);
close;
BW1=activecontour(I1,mask1,400);

% figure('units','normalized','outerposition',[0 0 1 1]);
% imshow(I1);
% hold on;
% title('Star');
% visboundaries(mask1,'Color','r');
% visboundaries(BW1,'Color','g');
% hold off;

%% Subjective contour illusion
I2=imread('ac02-SubjectiveContourIllusion.png');
figure;
imshow(I2);
mask2=roipoly(I2);
close;
BW2=activecontour(I2,mask2,400);

% figure('units','normalized','outerposition',[0 0 1 1]);
% imshow(I2);
% hold on;
% title('Subjective contour illusion');
% visboundaries(mask2,'Color','r');
% visboundaries(BW2,'Color','g');
% hold off;

%% MRI scan of prostate
I3=imread('ac03-prostate.png');
figure;
imshow(I3);
mask3=roipoly(I3);
close;
BW3=activecontour(I3,mask3,400,'edge','ContractionBias',-0.4);

% figure('units','normalized','outerposition',[0 0 1 1]);
% imshow(I3);
% hold on;
% title('MRI scan of prostate');
% visboundaries(mask3,'Color','r');
% visboundaries(BW3,'Color','g');
% hold off;
%% Bonner Münster
RGB=imread('ac04.png');
I4=rgb2gray(RGB);
figure;
imshow(I4);
mask4=roipoly(I4);
close;
BW4=activecontour(I4,mask4,800);  
%% Saving
f=figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,2,1);
imshow(I1);
hold on;
title('Star');
visboundaries(mask1,'Color','r');
visboundaries(BW1,'Color','g');
hold off;

subplot(2,2,2);
imshow(I2);
hold on;
title('Subjective contour illusion');
visboundaries(mask2,'Color','r');
visboundaries(BW2,'Color','g');
hold off;

subplot(2,2,3);
imshow(I3);
hold on;
title('MRI scan of prostate');
visboundaries(mask3,'Color','r');
visboundaries(BW3,'Color','g');
hold off;

subplot(2,2,4);
imshow(RGB);
hold on;
title('Bonner Münster');
visboundaries(mask4,'Color','r');
visboundaries(BW4,'Color','g');
hold off;

print(f,'contours.png','-dpng');