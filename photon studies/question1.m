function Vd=question1(Vs,R)
%initialize known parameters

m=1.5;
Is=2.11e-10; %A
Vt=25.3e-3; %V

f=@(Vd) ((Vs-Vd)/R)-(Is*(exp(Vd/(m*Vt))-1));

xl=-10000;
xr=1000;
xm=(xl+xr)/2;

%use bisection method

for N=1:100
    if (f(xl)*f(xm))<0
        xr=xm;
        xm=(xl+xr)/2;
    elseif (f(xl)*f(xm))>0
        xl=xm;
        xm=(xl+xr)/2;
    else
        xr=xm;
        xl=xm;
        break;
    end
end
Vd=xm
   
end