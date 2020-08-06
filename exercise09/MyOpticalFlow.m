function [ x, y, vx, vy ] = MyOpticalFlow( Ic, Il, N )
%MYOPTICALFLOW calculates the optical flow
%   [ x, y, vx, vy ] = MyOpticalFlow( Ic, Il, N )
%   x, y are row vector contain the coordinates of the domain of the flow
%   vector field
%   vx, vy are matrices containing the flow vector components
%   The inputs are the current grayscale image Ic, the last grayscale
%   image Il and the side length N of the local area Q.

% Coordinates of the domain of the flow vector field
sz=size(Ic);
n=floor(sz(1)/N);
last=n*N; %último pixel a tener en cuenta 
center=N/2;
x=[center:N:last-center];
y=x;

%Initialization of flow vector components
vx=zeros(length(x));
vy=vx;

%Spatial gradients
[Gx,Gy] = imgradientxy(Ic,'prewitt');

%Temporal gradient
Gt=Ic-Il;

% Estimation of flow vectors

k=1;
for i=1:N:N*(n-1)
    l=1;
    for j=1:N:N*(n-1)
        
    Gx1=reshape(Gx(i:i+N-1,j:j+N-1),[N^2,1]);
    Gy1=reshape(Gy(i:i+N-1,j:j+N-1),[N^2,1]);

    A=[Gx1 Gy1];

    h=-reshape(Gt(i:i+N-1,j:j+N-1),[N^2,1]);
    
    v=pinv(A)*h; 
    vx(k,l)=v(1);  
    vy(k,l)=v(2); %No estoy segura de si k y l llegan a ser n, llegan a tomar todos los valores o no
    
    l=l+1;
    end
    k=k+1;
end

end