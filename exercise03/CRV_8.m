%% CRV_08_Child's Play
% name : Pilar Navarro Ramírez
% student number : 3086150

%% clean up
clear all;
close all;
clc;
%% Gray-scale image
I= imread('cameraman.tif');
%% Octagon
x = [224 196 128 60 32 60 128 196 224];
y = [128 196 224 196 128 60 32 60 128];
figure;
imshow(I);
hold on;
plot(x,y,'rx :','LineWidth',2);
hold off; 
%% Haus vom Nikolaus
x=[60 60 196 196 60 128 196 60 196];
y=[196 100 196 100 100 30 100 196 196];
figure;
imshow(I);
hold on;
plot(x,y,'bo-','LineWidth',2,'MarkerEdgeColor','m');
hold off; 