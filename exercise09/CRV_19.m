%% CRV_19_QuiverPlot
% name:Pilar Navarro Ramirez
% student number: 3086150

%% clean up
clear all;
close all;
clc;

%% Vector fields
%f1
[x1,y1] = meshgrid(1:1:10,1:1:10);
u1 = zeros(size(x1));
v1 = ones(size(x1))./2;

% figure
% quiver(x1,y1,u1,v1,'AutoScaleFactor',0.4)

%f2

I=imread('cameraman.tif');

[x,y] = meshgrid(8:15:248,8:15:248);
v = ones(size(x))./2;
u=v;

% figure
% imshow(I);
% 
% hold on;
% quiver(x,y,u,v,'Color','g','AutoScaleFactor',0.4)
% hold off;

%% Saving
f=figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,2);
imshow(I);
hold on;
quiver(x,y,u,v,'Color','g','AutoScaleFactor',0.4)
hold off;

subplot(1,2,1);
quiver(x1,y1,u1,v1,'AutoScaleFactor',0.4)

print(f,'vectorfields.png','-dpng');
