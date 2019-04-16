function dVd=question2(Vs,dVs,R,dR)

f=@question1

x=Vs
h1=dVs
y=R
h2=dR

d1=((4.*(((f((x+h1),y))-(f((x-h1),y)))./(2.*h1)))-(((f((x+2*h1),y))-(f((x-2*h1),y)))./(4.*h1)))/3;
d2=((4.*(((f(x,(y+h2)))-(f(x,(y-h2))))./(2.*h2)))-(((f(x,(y+2*h2)))-(f(x,(y-2*h2))))./(4.*h2)))/3;

dVd=((d1*dVs)^2+(d2*dR)^2)^(1/2)

end