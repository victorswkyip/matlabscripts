function week5
clc;
R=1;
p_s=0.85;
p_w=1;

f=@(h) ((1/3)*pi*(3*R*(h^2)-(h^3))*p_w)-(((4/3)*pi*R^3)*p_s)

hl=0;
hr=2*R;
hm=(hl+hr)/2;

for N=1:100
    if (f(hl)*f(hm))<0
        hr=hm
        hm=(hl+hr)/2
    elseif (f(hl)*f(hm))>0
        hl=hm
        hm=(hl+hr)/2
    else
        hr=hm;
        hl=hm;
        break;
    end
end

root=hm

theta=0:0.1:pi
phi=0:0.2:2*pi

x=R.*sin(theta).*cos(phi)
y=R.*sin(theta).*sin(phi)  
z=R.*cos(theta)

% meshgrid(X,Y)

% plot(meshgrid)

plot(x,y,z)

end