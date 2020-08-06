% name : Pilar Navarro Ramírez
% student number : 3086150

function [ accu, h, alpha ] = MyHough( edgeImage )
%MYHOUGH detects straight lines vie Hough transform
%   [ accu, h, alpha ] = MyHough( edgeImage ) calculates the Hough
%   transform of the binary edgeImage. The hough image is contained in
%   accu. h is a vector containing the distance values. With D being the
%   diagonal length of the edgeImage, the values in h range from -D to D.
%   alpha contains the angle values in degree. These range from -90 to 89.

sz=size(edgeImage);
D=hypot(sz(1),sz(2));
D=round(D);
h=[-D:1:D];
alpha=[-90:1:89];


accu = zeros(length(h),length(alpha));
[x,y]=find(edgeImage);

%Hough Transform
for i=1:length(x)
        for k=1:length(alpha) 
            aux=round(x(i)*cos(alpha(k)*pi/180)+y(i)*sin(alpha(k)*pi/180));
            l=find(h==aux);
            if ~isempty(l)
                accu(l,k)=accu(l,k)+1;
            end  
        end      
end
end
