%% CRV_18_TimeToCollision
% name : Pilar Navarro Ramírez
% student number : 3086150
%% clean up
clear all;
close all;
clc;
%% First sequence
load('1/WS_time.mat')
heights1=zeros(1,18);
TTC1=zeros(1,18);
ToC1=zeros(1,18);

for i=1:18 
    filename = sprintf('1/image_%d.png',i);
    I=imread(filename);
    I=rgb2gray(I);
    I=edge(I,'Sobel');

    [H,T,R] = hough(I);
    peaks=houghpeaks(H,1);
    lines=houghlines(I,T,R,peaks);
    
     if ~isempty(lines)
         heights1(1,i)=sqrt((lines(1).point1(1)-lines(1).point2(1))^2 +(lines(1).point1(2)-lines(1).point2(2))^2);
     end
end 

for i=1:17
        d=(heights1(1,i+1)-heights1(1,i))/(time(i+1,1)-time(i,1));
        TTC1(1,i)=heights1(1,i)/d;
        ToC1(1,i)=TTC1(1,i)+time(i,1);
end

tim1=median(ToC1(ToC1~=0))

%% Second sequence
load('2/WS_time.mat')
heights2=zeros(1,40);
TTC2=zeros(1,40);
ToC2=zeros(1,40);

for i=1:40 
    filename = sprintf('2/image_%d.png',i);
    I=imread(filename);
    I=rgb2gray(I);
    I=edge(I,'Sobel');

    [H,T,R] = hough(I);
    peaks=houghpeaks(H,1);
    lines=houghlines(I,T,R,peaks);
    
     if ~isempty(lines)
         %heights2(1,i)=norm(lines(1).point1-lines(1).point2);
         heights2(1,i)=sqrt((lines(1).point1(1)-lines(1).point2(1))^2 +(lines(1).point1(2)-lines(1).point2(2))^2);
     end
end 

for i=1:39
        d=(heights2(1,i+1)-heights2(1,i))/(time(i+1,1)-time(i,1));
        TTC2(1,i)=heights2(1,i)/d;
        ToC2(1,i)=TTC2(1,i)+time(i,1);
end

tim2=median(ToC2(ToC2~=0))


%% Third sequence
load('3/WS_time.mat')
heights=zeros(1,22);
TTC=zeros(1,22);
ToC=zeros(1,22);

for i=1:22 
    filename = sprintf('3/image_%d.png',i);
    I=imread(filename);
    I=rgb2gray(I);
    I=imgaussfilt(I,2);
    I=edge(I,'Sobel');

    [H,T,R] = hough(I);
    peaks=houghpeaks(H,1);
    lines=houghlines(I,T,R,peaks,'FillGap',30);
    
     if ~isempty(lines)
         heights(1,i)=sqrt((lines(1).point1(1)-lines(1).point2(1))^2 +(lines(1).point1(2)-lines(1).point2(2))^2);
     end
end 

for i=1:21
        d=(heights(1,i+1)-heights(1,i))/(time(i+1,1)-time(i,1));
        TTC(1,i)=heights(1,i)/d;
        ToC(1,i)=TTC(1,i)+time(i,1);
end

tim3=median(ToC(ToC~=0))





