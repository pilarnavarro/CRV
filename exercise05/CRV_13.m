%% CRV_13_houghlines
% name : Pilar Navarro Ramírez
% student number : 3086150
%% clean up
clear all;
close all;
clc;
%% edge01
I=imread('edge01.png');
I=double(I);

[H1,T1,R1] = hough(I);
peaks1=houghpeaks(H1,4,'threshold',0.4*max(H1(:))); 
lines1=houghlines(I,T1,R1,peaks1,'FillGap',40);

%% edge02
I2=imread('edge02.png');
I2=double(I2);

[H,T,R] = hough(I2);
peaks=houghpeaks(H,4);
lines2=houghlines(I2,T,R,peaks);
%% Visualization
f=figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1);
imshow(I);
title('edge image 1');
hold on;

for i=1:length(lines1)
   xy=[lines1(i).point1; lines1(i).point2];
   plot(xy(:,1),xy(:,2),'--y','LineWidth',2);
end

hold off;

subplot(1,2,2);
imshow(I2);
title('edge image 2');
hold on;

for i=1:length(lines2)
   xy=[lines2(i).point1; lines2(i).point2];
   plot(xy(:,1),xy(:,2),'--g','LineWidth',2);
end

hold off;

