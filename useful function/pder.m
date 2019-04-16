function [dfdx,dfdy,dfdz]=pder(f,x,dx,y,dy,z,dz)
N=nargin;
if (N==3)
    dfdx=(1/3).*(4.*((f(x+dx)-f(x-dx))./(2.*dx))-((f(x+2.*dx)-f(x-2.*dx))./(4.*dx)))
elseif (N==5)
    dfdx=(1/3).*(4.*((f(x+dx,y)-f(x-dx,y))./(2.*dx))-((f(x+2.*dx,y)-f(x-2.*dx,y))./(4.*dx)))
    dfdy=(1/3).*(4.*((f(x,y+dy)-f(x,y-dy))./(2.*dy))-((f(x,y+2.*dy)-f(x,y-2.*dy))./(4.*dy)))
elseif(N==7)
    dfdx=(1/3).*(4.*((f(x+dx,y,z)-f(x-dx,y,z))./(2.*dx))-((f(x+2.*dx,y,z)-f(x-2.*dx,y,z))./(4.*dx)))
    dfdy=(1/3).*(4.*((f(x,y+dy,z)-f(x,y-dy,z))./(2.*dy))-((f(x,y+2.*dy,z)-f(x,y-2.*dy,z))./(4.*dy)))
    dfdz=(1/3).*(4.*((f(x,y,z+dz)-f(x,y,z-dz))./(2.*dz))-((f(x,y,z+2.*dz)-f(x,y,z-2.*dz))./(4.*dz)))
else
    error('wrong number of inputs')
end
