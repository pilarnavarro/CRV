%% CRV_23_KalmanFilterParabola
% name: Pilar Navarro Ramirez
% student number: 3086150

%% clean up
clear all;
close all;
clc;
%% True positions
a=-0.05;
b=19;
c=150;

X=[1:0.1:40];

Y=zeros(1,length(X));

for i=1:length(X)
    Y(1,i)=a*(X(i)-b)^2+c;
end
%% Initialization 
Pi=[1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];
H=[1 0 0 0; 0 1 0 0];
Q=10^(-6)*[80 1 1 1; 1 80 1 1; 1 1 80 1; 1 1 1 80];
R=10^(-3)*[50 1; 1 50];
Ck=10^(-9)*[1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
sk=[1 133 0 0]';
mk=zeros(2,length(X));
estimations=zeros(2,length(X));
%% Noise simulation
for i=1:length(X)
    C=chol(R)'*randn(2,1);
    mk(1,i)= X(i)+ C(1);
    mk(2,i)= Y(i)+ C(2);
end
%% Kalman Filter
I=eye(4);
for i=1:length(X)
Ck_prime=Pi*Ck*(Pi)'+Q;
G=Ck_prime*(H')*(pinv(H*Ck_prime*(H')+R));
Ck=(I-G*H)*Ck_prime*(I-G*H)'+G*R*G';

sk_prime=Pi*sk;
sk=sk_prime+G*(mk(:,i)-H*Pi*sk); 
estimations(1,i)= sk(1);
estimations(2,i)= sk(2);
end

%% Plotting
plot(X,Y,'g.',mk(1,:),mk(2,:),'r.',estimations(1,:),estimations(2,:),'b.')
legend('Predictions','Measurements','Estimations');