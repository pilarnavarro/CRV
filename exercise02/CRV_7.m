%% CRV_07_EdgeDetection
% name : Pilar Navarro Ramírez
% student number : 3086150
%% %% Clean up
clear all;
close all;
clc;
%% Gray-scale image
cameraman=imread('cameraman.tif');
cameraman=im2double(cameraman); %This function converts the image to double precision and 
                               %normalizes the image dividing by the maximum (255)
%% SimpleDerivation
fop_x=[-1 0 1];
fop_y=(fop_x)';
h_derivation=imfilter(cameraman,fop_x);
v_derivation=imfilter(cameraman,fop_y);
MoG=sqrt(h_derivation.^2 + v_derivation.^2);
Bin1=(MoG>0.5);
%Another option -> Bin1=imbinarize(MoG,0.5);
Bin2=(MoG>1.5); 

figure
subplot(2,3,1) 
imshow(cameraman)
title('Original')

subplot(2,3,2)
imshow(h_derivation)
title('Horizontal derivation')

subplot(2,3,3)
imshow(v_derivation)
title('Vertical derivation')

subplot(2,3,4)
imshow(MoG)
title('Magnitude of Gradient')

subplot(2,3,5)
imshow(Bin1)
title('Binary edge map 0.5')

subplot(2,3,6)
imshow(Bin2)
title('Binary edge map 1.5')
%% Prewitt
fop_x=[-1 0 1;-1 0 1;-1 0 1];
fop_y=(fop_x)';
h_derivation=imfilter(cameraman,fop_x);
v_derivation=imfilter(cameraman,fop_y);
MoG=sqrt(h_derivation.^2 + v_derivation.^2);
Bin1=(MoG>0.5);
%Bin2=(MoG>1.5); 
Bin2=imbinarize(MoG,1.5);

figure
subplot(2,3,1) 
imshow(cameraman)
title('Original')

subplot(2,3,2)
imshow(h_derivation)
title('Horizontal derivation')

subplot(2,3,3)
imshow(v_derivation)
title('Vertical derivation')

subplot(2,3,4)
imshow(MoG)
title('Magnitude of Gradient')

subplot(2,3,5)
imshow(Bin1)
title('Binary edge map 0.5')

subplot(2,3,6)
imshow(Bin2)
title('Binary edge map 1.5')
%% Sobel
fop_x=[-1 0 1;-2 0 2;-1 0 1];
fop_y=(fop_x)';
h_derivation=imfilter(cameraman,fop_x);
v_derivation=imfilter(cameraman,fop_y);
MoG=sqrt(h_derivation.^2 + v_derivation.^2);
Bin1=(MoG>0.5);
Bin2=(MoG>1.2); 

figure
subplot(2,3,1) 
imshow(cameraman)
title('Original')

subplot(2,3,2)
imshow(h_derivation)
title('Horizontal derivation')

subplot(2,3,3)
imshow(v_derivation)
title('Vertical derivation')

subplot(2,3,4)
imshow(MoG)
title('Magnitude of Gradient')

subplot(2,3,5)
imshow(Bin1)
title('Binary edge map 0.5')

subplot(2,3,6)
imshow(Bin2)
title('Binary edge map 1.2')
%% Edge
bin_Prewitt=edge(cameraman,'Prewitt');
bin_Sobel=edge(cameraman,'Sobel');
bin_Canny=edge(cameraman,'Canny');

figure
subplot(2,2,1) 
imshow(cameraman)
title('Original')

subplot(2,2,2)
imshow(bin_Prewitt)
title('Binary edge map Prewitt')

subplot(2,2,3)
imshow(bin_Sobel)
title('Binary edge map Sobel')

subplot(2,2,4)
imshow(bin_Canny)
title('Binary edge map Canny')
%% Edgetest1
original=imread('edgetest1.png');
smoothed=medfilt2(original);
bin=edge(smoothed,'Sobel');

figure
subplot(1,3,1)
imshow(original)
title('original')

subplot(1,3,2)
imshow(smoothed)
title('original image smoothed')

subplot(1,3,3)
imshow(bin)
title('Binary edge map')
%% Edgetest2
original=imread('edgetest2.png');
smoothed=imgaussfilt(original,1.5);
bin=edge(smoothed,'Sobel');

figure
subplot(1,3,1)
imshow(original)
title('original')

subplot(1,3,2)
imshow(smoothed)
title('original image smoothed')

subplot(1,3,3)
imshow(bin)
title('Binary edge map')
%% Edgetest3
original=imread('edgetest3.png');
smoothed=imgaussfilt(original,1.5);
bin=edge(smoothed,'Sobel');

figure
subplot(1,3,1)
imshow(original)
title('original')

subplot(1,3,2)
imshow(smoothed)
title('original image smoothed')

subplot(1,3,3)
imshow(bin)
title('Binary edge map')
%% Edgetest4
original=imread('edgetest4.png');
smoothed=medfilt2(original);
bin=edge(smoothed,'Canny');

figure
subplot(1,3,1)
imshow(original)
title('original')

subplot(1,3,2)
imshow(smoothed)
title('original image smoothed')

subplot(1,3,3)
imshow(bin)
title('Binary edge map')
%% Edgetest5
original=imread('edgetest5.png');
smoothed=medfilt2(original);
bin=edge(smoothed,'Canny');

figure
subplot(1,3,1)
imshow(original)
title('original')

subplot(1,3,2)
imshow(smoothed)
title('original image smoothed')

subplot(1,3,3)
imshow(bin)
title('Binary edge map')
%% Edgetest6
original=imread('edgetest6.png');
smoothed=imgaussfilt(original,2.3);
bin=edge(smoothed,'Canny');

figure
subplot(1,3,1)
imshow(original)
title('original')

subplot(1,3,2)
imshow(smoothed)
title('original image smoothed')

subplot(1,3,3)
imshow(bin)
title('Binary edge map')
%% Edgetest7
original=imread('edgetest7.png');
smoothed=imgaussfilt(original,6);
bin=edge(smoothed,'Canny');

figure
subplot(1,3,1)
imshow(original)
title('original')

subplot(1,3,2)
imshow(smoothed)
title('original image smoothed')

subplot(1,3,3)
imshow(bin)
title('Binary edge map')
%% Edgetest8
original=imread('edgetest8.png');
smoothed=imgaussfilt(original,2.5);
bin=edge(smoothed,'Sobel');

figure
subplot(1,3,1)
imshow(original)
title('original')

subplot(1,3,2)
imshow(smoothed)
title('original image smoothed')

subplot(1,3,3)
imshow(bin)
title('Binary edge map')




