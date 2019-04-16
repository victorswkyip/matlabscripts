function week9a
close all
clear all
clc

x_A(1)=0.5;
x_A(2)=0.5;

x_B(1)=0;
x_B(2)=0;

t=0:0.25:500;
xstep=0.25;
k=0.01;

for n=2:length(t)-1
    x_A(n+1)=2*x_A(n)-x_A(n-1)-xstep^2*(x_A(n)+k*(x_A(n)-x_B(n)));
    x_B(n+1)=2*x_B(n)-x_B(n-1)-xstep^2*(x_B(n)-k*(x_A(n)-x_B(n)));
end

plot(t,x_A,'k',t,x_B,'r')

end