function week9b
close all
clear all
clc

a=2;
b=0.5;
c=0;
N=1000;
A=1e-4;
step=1e-10;
R=5;

flux=@(I) N*A*(a/(1+exp(-b*(I-c)))-a/2);
vs=@(t) 50*cos(2*pi*60*t);

t=0:A:0.05;
N2=length(t);
I=zeros(N2,1);
I(1)=0;
vs=vs(t);

for n=1:1:N2-1 
    gamma=pder(flux,I(n),1e-10);
    I(n+1)=I(n)+((vs(n)-R*I(n))/gamma)*A;
end

plot(t,I)
end