function dydx=der(f,x,h)

t1=f(x+h);
t2=f(x-h);
t3=f(x+2*h);
t4=f(x-2*h);

t5=4*((t1-t2)/(2*h));
t6=(t3-t4)/(4*h);

dydx=(t5-t6)/3

plot(x,dydx);
end
