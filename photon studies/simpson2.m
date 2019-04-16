function ans=simpson2
clc;
Nx=2; Ny=1;
xi=0; xf=2;
yi=0; yf=1;

hx=(xf-xi)/(2*Nx);
hy=(yf-yi)/(2*Ny);

[X,Y]=meshgrid(xi:hx:xf,yi:hy:yf);

wx=weight(2*Nx+1);
wy=weight(2*Ny+1);
Z=f(X,Y);

integ=(transpose(Z*wx*hx/3))*wy*hy/3

end

function [Z]=f(X,Y)
Z=(X.^2).*Y;
end

function w=weight(z)
w=ones(z,1);
w(2:1:z-1)=2;
w(2:2:z-1)=4;
end
