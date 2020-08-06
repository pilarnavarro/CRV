%% CRV_03_Vectorization
% name:Pilar Navarro Ramírez
% student number: 3086150

%% Matrix generation
size=1000;
A=rand(size)
%% Squaring with for-loops v1
C=A
tic
for i=1:size
	for j=1:size
		C(i,j)=C(i,j)^2;
	end
end
time1=toc
C
%% Squaring with for-loops v2
D=A
tic
for i=1:size
	for j=1:size
		D(j,i)=D(j,i)^2;
	end
end
time2=toc
D
%% Squaring using MATLAB functions
B=A
tic
B=B.^2;
time3=toc
B