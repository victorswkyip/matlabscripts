function simpson3
clc;
Nx=120; Ny=120; Nz=120;
xi=0; xf=5; 
yi=0; yf=2;
zi=0; zf=1;

hx=(xf-xi)/Nx;
hy=(yf-yi)/Ny;
hz=(zf-zi)/Nz;

sum=0;

for x=xi+hx/2:hx:xf-hx/2
    for y=yi+hy/2:hy:yf-hy/2
        for z=zi+hz/2:hz:zf-hz/2
            sum=sum+f(x,y,z)*hx*hy*hz;
        end
    end
end

sum


function t=f(x,y,z)
t=(x*z)/(1+y);
end

end