%% CRV_22_OpticalFlow
% name:Pilar Navarro Ramirez
% student number: 3086150

%% clean up
clear all;
close all;
clc;

%% Sequence 1
for i=2:43
    filename = sprintf('1/image_%d.png',i);
    filenameP = sprintf('1/image_%d.png',i-1);
    I=imread(filename);
    P=imread(filenameP);
    I=double(I);
    P=double(P);
    
    fN=sprintf('VectorsFields_%d.png',i-1);
    [ x, y, vx, vy ] = MyOpticalFlow( I, P, 20 );  
    MyOpticalFlowVisualization( I, x, y, vx, vy,1.2, fN);
end

%% Sequence 2
for i=2:43
    filename = sprintf('2/image_%d.png',i);
    filenameP = sprintf('2/image_%d.png',i-1);
    I=imread(filename);
    P=imread(filenameP);
    I=double(I);
    P=double(P);
    
    fN=sprintf('VectorsFields2_%d.png',i-1);
    [ x, y, vx, vy ] = MyOpticalFlow( I, P, 10 );
    MyOpticalFlowVisualization( I, x, y, vx, vy,1 , fN);
end

%% Sequence 3  
for i=2:50
    filename = sprintf('3/image_%d.png',i);
    filenameP = sprintf('3/image_%d.png',i-1);
    I=imread(filename);
    I_g=rgb2gray(I);    
    P=imread(filenameP);
    P_g=rgb2gray(P);
    I_g=double(I_g)/255;
    P_g=double(P_g)/255;
    
     fN=sprintf('VectorsFields3_%d.png',i-1);
     [ x, y, vx, vy ] = MyOpticalFlow( I_g, P_g, 40 );
     MyOpticalFlowVisualization( I, x, y, vx, vy,1.2, fN);
end

%As the size of the local areas increment, the number of them decrement.
%Therefore, the amount of vectors is smaller and their size is bigger. With
%less arrows, one can visualize better the displacement of the object. Another
%aspect to remark is that only in the inner part of the object the flow
%vectors can be calculated correctly. In the borders of the object only the
%normal part of the vectors can be obtained, so the real optical flow
%cannot be represented.That is why in the borders the vectors do not
%describe properly the movement of the points. 