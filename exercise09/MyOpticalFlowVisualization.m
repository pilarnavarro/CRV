function [ ] = MyOpticalFlowVisualization( I, x, y, vx, vy, sF, fN)
%MYOPTICALFLOWVISUALIZATION saves visualization of optical flow
%   MyOpticalFlowVisualization( I, x, y, vx, vy, fN, sF) shows the image I
%   and visualizes the optical flow with components vx and vy and the
%   coordinates x and y. The plot of the flow vectors is auto scaled with
%   the scale factor sF. The resulting figure is saved as a png image file
%   named fN.

[x,y] = meshgrid(x,y);

f=figure('units','normalized','outerposition',[0 0 1 1]);
imshow(I);
hold on;
quiver(x,y,vx,vy,'Color','g','AutoScaleFactor',sF)
hold off;

print(f,fN,'-dpng');
close(f);
end
