%% CRV_11_MyHough
% name : Pilar Navarro Ramírez
% student number : 3086150

%% edge01
I=imread('edge01.png');
I=double(I);
bin=edge(I,'Sobel');

[ accu, h, alpha ]=MyHough(bin);

% figure;
% subplot(1,2,1)
% imshow(I)
% title('edge image')
% subplot(1,2,2)
% imshow(accu,[]) 
% axis square
% title('hough image')

%Highest peak

[M,index]=max(accu); 
[M2,index2]=max(M);
ialpha_max=index2;
ih_max=index(index2);
h_max=h(ih_max);
alpha_max=alpha(ialpha_max);



figure;
subplot(1,2,1)
imshow(I)
title('edge image')
hold on;
fimplicit(@(y,x) x*cos(alpha_max*pi/180) + y*sin(alpha_max*pi/180)-h_max,'--c');
hold off;
subplot(1,2,2)
imshow(accu,[]) 
axis square
title('hough image')

%Highest N peaks

N=48;
h_peaks=zeros(N);
alpha_peaks=zeros(N);
copy=accu;

for i=1:N
    [M,index]=max(copy); 
    [M2,index2]=max(M);
    ialpha_max=index2;
    ih_max=index(index2);
    h_peaks(i)=h(ih_max);   
    alpha_peaks(i)=alpha(ialpha_max);
    copy(ih_max,ialpha_max)=0;
end

figure;
subplot(1,2,1)
imshow(I)
title('edge image')
for i=1:length(alpha_peaks)
    hold on;
    fimplicit(@(y,x) x*cos(alpha_peaks(i)*pi/180) + y*sin(alpha_peaks(i)*pi/180)-h_peaks(i),'--g');
    hold off;
end

subplot(1,2,2)
imshow(accu,[]) 
axis square
title('hough image')

%% edge02
I=imread('edge02.png');
I=double(I);
bin=edge(I,'Sobel');

[ accu, h, alpha ]=MyHough(bin);

% figure;
% subplot(1,2,1)
% imshow(I)
% title('edge image')
% subplot(1,2,2)
% imshow(accu,[]) 
% axis square
% title('hough image')

%Highest peak

[M,index]=max(accu); 
[M2,index2]=max(M);
ialpha_max=index2;
ih_max=index(index2);
h_max=h(ih_max);
alpha_max=alpha(ialpha_max);



figure;
subplot(1,2,1)
imshow(I)
title('edge image')
hold on;
fimplicit(@(y,x) x*cos(alpha_max*pi/180) + y*sin(alpha_max*pi/180)-h_max,'--c');
hold off;
subplot(1,2,2)
imshow(accu,[]) 
axis square
title('hough image')

%Highest N peaks

N=12;
h_peaks=zeros(N);
alpha_peaks=zeros(N);
copy=accu;

for i=1:N
    [M,index]=max(copy); 
    [M2,index2]=max(M);
    ialpha_max=index2;
    ih_max=index(index2);
    h_peaks(i)=h(ih_max);   
    alpha_peaks(i)=alpha(ialpha_max);
    copy(ih_max,ialpha_max)=0;
end

figure;
subplot(1,2,1)
imshow(I)
title('edge image')
for i=1:length(alpha_peaks)
    hold on;
    fimplicit(@(y,x) x*cos(alpha_peaks(i)*pi/180) + y*sin(alpha_peaks(i)*pi/180)-h_peaks(i),'--g');
    hold off;
end

subplot(1,2,2)
imshow(accu,[]) 
axis square
title('hough image')
