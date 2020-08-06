%% MyActiveContourTesting

%% Init
clear all;
close all;
clc;

%% Testing
I = ones(200);
I(40:60,140:160) = 0;
x0 = [35 45 55 65 65 55 45 35 35]';
y0 = [145 135 135 145 155 165 165 155 145]';
[ x, y ] = MyActiveContour( I, x0, y0, 50, 0.1 )