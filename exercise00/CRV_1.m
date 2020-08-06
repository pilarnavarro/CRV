%% CRV_01_Write a Script 
% name:Pilar Navarro Ramírez
% student number: 3086150

%% Clean up 

clear
close all
clc
%% Plotting
v=linspace(-2*pi,2*pi,300);
c=cos(v);
s=sin(v);

plot(v,s,'r-')
hold on
plot(v,c,'b-')
title('Sine and cosine')
ylabel('Values')
xlabel('Points')
legend('cos(x)','sin(x)')
xlim([-2*pi,2*pi])

