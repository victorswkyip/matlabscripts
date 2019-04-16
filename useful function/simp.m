function simp
N=10;
xb=0.5; xa=-0.5;
h=(xb-xa)/(2*N);
int=0;
for x=xa+h:2*h:xb-h
    int=int+(f(x-h)+4*f(x)+f(x+h))*h/3;
end
int
end

function y=f(x)
y=((2*pi)^-0.5)*exp((-x.^2)./2);
end