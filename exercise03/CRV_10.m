%% CRV_10_MyActiveContour
% name : Pilar Navarro Ramírez
% student number : 3086150

%% clean up
clear all;
close all;
clc;
%% Test1
I= imread('Test1.png');
% Initial curve
figure;
imshow(I);
[BW,x0,y0]=roipoly(I);
x0=round(x0);
y0=round(y0);
close;

%Snake method
[x,y]=MyActiveContour(I,x0,y0,1000,0.5);
%Figures
figure;
subplot(1,2,1)
imshow(I);
title('Initial curve')
hold on;
plot(x0,y0,'g.-','LineWidth',2,'MarkerEdgeColor','m');
hold off;

subplot(1,2,2)
imshow(I);
title('Final curve')
hold on;
plot(x,y,'m*-','LineWidth',1,'MarkerEdgeColor','y');
hold off;

%% Test2
I= imread('Test2.png');
% Initial curve
figure;
imshow(I);
[BW,x0,y0]=roipoly(I);
x0=round(x0);
y0=round(y0);
close;

%Snake method
[x,y]=MyActiveContour(I,x0,y0,1000,5);
%Figures
figure;
subplot(1,2,1)
imshow(I);
title('Initial curve')
hold on;
plot(x0,y0,'co-','LineWidth',2,'MarkerEdgeColor','m');
hold off; 

subplot(1,2,2)
imshow(I);
title('Final curve')
hold on;
plot(x,y,'m*-','LineWidth',1,'MarkerEdgeColor','y');
hold off;
%% Test3
I= imread('Test3.png');
% Initial curve
figure;
imshow(I);
[BW,x0,y0]=roipoly(I);
x0=round(x0);
y0=round(y0);
close;
%Snake method
[x,y]=MyActiveContour(I,x0,y0,50,0.5);
%Figures
figure;
subplot(1,2,1)
imshow(I);
title('Initial curve')
hold on;
plot(x0,y0,'gx-','LineWidth',2,'MarkerEdgeColor','m');
hold off; 

subplot(1,2,2)
imshow(I);
title('Final curve')
hold on;
plot(x,y,'m*-','LineWidth',1,'MarkerEdgeColor','y');
hold off;
%% Coins
I= imread('coins.png');
% Initial curve
figure;
imshow(I);
[BW,x0,y0]=roipoly(I);
close;
x0=round(x0);
y0=round(y0);

%Snake method
[x,y]=MyActiveContour(I,x0,y0,50,0.5);
%Figures
figure;
subplot(1,2,1)
imshow(I);
title('Initial curve')
hold on;
plot(x0,y0,'cx-','LineWidth',2,'MarkerEdgeColor','g');
hold off; 

subplot(1,2,2)
imshow(I);
title('Final curve')
hold on;
plot(x,y,'m*-','LineWidth',1,'MarkerEdgeColor','y');
hold off;