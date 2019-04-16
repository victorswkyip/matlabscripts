function [x,Fmax]=question4
clc;
clear all
close all
Fmax=0;

for a=0:0.0001:1
    if F(a)>Fmax
        Fmax=F(a);
        x=a;
    end
end
Fmax
x
end

function int=F(a)
N=100;
xi=a; xf=a+1;
h=(xf-xi)/(2*N);

x=xi:h:xf;

Nx=length(x);
w=ones(Nx,1);
w(2:1:Nx-1)=2;
w(2:2:Nx-1)=4;
int=f(x)*w*h/3;
end

function y=f(t)
y=(t.^(0.5)).*exp(-t);
end

