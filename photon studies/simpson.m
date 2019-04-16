function ans=simpson
clc;
f=@(z) exp((-z.^2)./2);
t=0.5;
N=5;
increments=(t-(-t))/N;
x=-t:increments:t;
h=increments;

for i=1:1:N
area(i)=(h/6)*(f(x(i))+4.*f((x(i)+x(i+1))/2)+f(x(i+1)));
end

temp=sumelements(area);
C=(2*pi)^(-0.5);
ans=C.*temp;
end