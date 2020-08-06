%% CRV_04_ImagesReadShowWrite
% name : Pilar Navarro Ramírez
% student number : 3086150

%% clean up
clear all;
close all;
clc;
%% Gray-scale image
cameraman = imread('cameraman.tif');
figure 
imshow(cameraman)

%% RGB image
rgbImage=imread('peppers.png');
figure
imshow(rgbImage)

figure
subplot(2,2,1) 
imshow(rgbImage)
title('original')

subplot(2,2,2)
imshow(rgbImage(:,:,1))
title('red')

subplot(2,2,3)
imshow(rgbImage(:,:,2))
title('green')

subplot(2,2,4)
imshow(rgbImage(:,:,3))
title('blue')

%% rgb2intensity
figure
subplot(2,2,1) 
imshow(rgbImage)
title('original')

meanImage = uint8(mean(rgbImage, 3)); %Colours are in the third dimension of the array, so we make the mean of this dimension
subplot(2,2,2)
imshow(meanImage)
title('mean')

medianImage = uint8(median(rgbImage, 3));
subplot(2,2,3)
imshow(medianImage)
title('median')

subplot(2,2,4)
grayImage=rgb2gray(rgbImage);
imshow(grayImage)
title('rgb2gray')
%% Saving
imwrite(meanImage, 'mean.png','png') 
imwrite(medianImage,'median.png','png')
imwrite(grayImage,'rgb2gray.png','png')