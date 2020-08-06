%% CRV_05_Smoothing, noise and denoising
% name: Pilar Navarro Ramírez
% student number: 3086150
%% clean up
clear all;
close all;
clc;
%% Gray-scale image
cameraman = imread('cameraman.tif');
%% Gaussian operator
Gaus=[ 1 2 1;2 4 2;1 2 1]
addition=sum(Gaus,'all');
GausNormalized=Gaus/addition
sum(GausNormalized,'all')

h1=fspecial('gaussian', 3 , 0.5) 
sum(h1,'all')
mean(h1,'all')
h2=fspecial('gaussian', 3 , 0.75) 
sum(h2,'all')
h3=fspecial('gaussian', 3 , 1) 
sum(h3,'all')
h4=fspecial('gaussian', 3 , 6) 
sum(h4,'all')
%A high value of sigma indicates that the data points (values in the matrix) tend to be close to the mean,
%while a low value of sigma indicates that the data points are spread out over a wider range of values. 

filter1=imfilter(cameraman,GausNormalized);
filter2=imfilter(cameraman,h2); 

figure
subplot(2,2,[1, 2])
imshow(cameraman);
title('original')

subplot(2,2,3)
imshow(filter1);
title('my own operator')

subplot(2,2,4)
imshow(filter2);
title('fspecial operator') 
%% Gaussian noise
noisyImage=imnoise(cameraman,'gaussian'); %zero mean, 0.01 variance

figure
subplot(2,1,1)
imshow(cameraman);
title('original')

subplot(2,1,2)
imshow(noisyImage);
title('noisy image')

smoothedOriginal=imgaussfilt(cameraman,1);  %The higher the sigma value is, the more smoothed the image is, so there are fewer details
smoothedNoisy=imgaussfilt(noisyImage,1);

figure
subplot(2,2,1)
imshow(cameraman);
title('original')

subplot(2,2,3)
imshow(noisyImage);
title('noisy image')

subplot(2,2,2)
imshow(smoothedOriginal);
title('original image smoothed')

subplot(2,2,4)
imshow(smoothedNoisy);
title('noisy image smoothed')
%% Impulse noise
noisyImageS_P=imnoise(cameraman,'salt & pepper');
smoothedNoisyS_P=imgaussfilt(noisyImageS_P,1.5);
smoothedNoisyS_P_2=medfilt2(noisyImageS_P);

figure
subplot(3,2,1)
imshow(cameraman);
title('original')

subplot(3,2,3)
imshow(noisyImageS_P);
title('noisy image S&P')

subplot(3,2,2)
imshow(smoothedOriginal);
title('original image smoothed')

subplot(3,2,4)
imshow(smoothedNoisyS_P);
title('noisy image S&P smoothed')

subplot(3,2,[5,6])
imshow(smoothedNoisyS_P_2);
title('noisy image S&P smoothed medfilt2')








