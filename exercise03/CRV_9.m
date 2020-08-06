%% CRV_08_Child's Play
% name : Pilar Navarro Ramírez
% student number : 3086150

%% clean up
clear all;
close all;
clc;
%% Gray-scale image
I= imread('cameraman.tif');
figure;
[BW,xi2,yi2]=roipoly(I);
xi2=round(xi2);
yi2=round(yi2);
close;
figure;
imshow(I);
hold on;
plot(xi2,yi2,'y*--','LineWidth',1,'MarkerEdgeColor','b');
hold off; 