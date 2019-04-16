function dfdx=der(f,x,h)
dfdx=(1/3)*(4*((f(x+h)-f(x-h))/(2*h))-((f(x+2*h)-f(x-2*h))/(4*h)))
end