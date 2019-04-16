function [d1,d2,d3]=pder(f,x,h1,y,h2,z,h3)
if nargin(f)==1
    d1=((4.*(((f(x+h1))-(f(x-h1)))./(2.*h1)))-(((f(x+2*h1))-(f(x-2*h1)))./(4.*h1)))/3;
elseif nargin(f)==2
    d1=((4.*(((f((x+h1),y))-(f((x-h1),y)))./(2.*h1)))-(((f((x+2*h1),y))-(f((x-2*h1),y)))./(4.*h1)))/3;
    d2=((4.*(((f(x,(y+h2)))-(f(x,(y-h2))))./(2.*h2)))-(((f(x,(y+2*h2)))-(f(x,(y-2*h2))))./(4.*h2)))/3;

elseif nargin(f)==3
    d1=((4.*(((f((x+h1),y,z))-(f((x-h1),y,z)))./(2.*h1)))-(((f((x+2*h1),y,z))-(f((x-2*h1),y,z)))./(4.*h1)))/3;
    d2=((4.*(((f(x,(y+h2),z))-(f(x,(y-h2),z)))./(2.*h2)))-(((f(x,(y+2*h2),z))-(f(x,(y-2*h2),z)))./(4.*h2)))/3;
    d3=((4.*(((f(x,y,(z+h3)))-(f(x,y,(z-h3))))./(2.*h2)))-(((f(x,y,(z+2*h3)))-(f(x,y,(z-2*h3))))./(4.*h2)))/3;
end
end

    