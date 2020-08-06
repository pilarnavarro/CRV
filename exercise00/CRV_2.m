%% CRV_02_Implementing functions
% name:Pilar Navarro Ramírez
% student number: 3086150

%% Execution
n=[1 2 3 42];

tic
for i=1:4
    f1=MyFacRec(n(i))
end
time1=toc

tic
for i=1:4
    f2=MyFacIter(n(i))
end
time2=toc

tic
for i=1:4
    f3=factorial(n(i))
end
time3=toc



