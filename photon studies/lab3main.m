function lab3main
clc;
%static method starts now

A=importdata('Lab3A.csv'); upmass=A(:,1); dupmass=A(:,2); upext=A(:,3); dupext=A(:,4);
[b, m, db, dm]=linreg(upmass, upext, dupext)
f=@(upmass) m*upmass+b;
df=erprop(f,upmass,dupmass)
figure(1)
hold on
errorbar(upmass,upext,dupext,'*');
plot(upmass, m*upmass+b);
legend('Experiment', 'Extension=6.8318e-04*Mass+1.9250e-04','Location','Northwest');
xlabel('Mass (kg)')
ylabel('Extension (m)')
title('Amount of Wire Extension Based on Increasing Varied Masses');
hold off

B=importdata('Lab3B.csv'); downmass=B(:,1); ddownmass=B(:,2); downext=B(:,3); ddownext=B(:,4);
[b2, m2, db2, dm2]=linreg(downmass, downext, ddownext)
g=@(downmass) m2*downmass+b2;
dg=erprop(g,downmass,ddownmass)
figure(2)
hold on
errorbar(downmass, downext,ddownext,'*');
plot(downmass, m2*downmass+b2);
legend('Experiment', 'Extension=6.9152e-04*Mass+1.8524e-04','Location','Northwest');
xlabel('Mass (kg)')
ylabel('Extension (m)')
title('Amount of Wire Extension Based on Decreasing Varied Masses');
hold off

%calculating E via the static method
g=9.81; %m/s^2
l=2.83; %m
d=0.52/1000; %m
r=d/2; %m
dl=0.01;
dd=0.01/1000;
dr=r*(dd/d);
A=pi*r^2; %m^2
dA=A*2*dr/r

E=(g*l)/(A*m) %upmasses
dE=E*((dl/l)^2+(dA/A)^2+(dm/m))^0.5
E2=(g*l)/(A*m2) %downmasses
dE2=E*((dl/l)^2+(dA/A)^2+(dm2/m2))^0.5


%dynamic method starts now

C=importdata('Lab3C.csv'); favg=C(:,1); dfavg=C(:,2);

M=6.949; %kg
dM=0.001; %kg

l2=2.93; %m
dl2=0.01; %m

d2=0.77/1000; %m
dd2=0.01/1000;%m

r2=d2/2; %m
dr2=r2*(dd2/d2);%m

A2=pi*r2^2 %m^2
dA2=A2*2*dr2/r2%m^2

E3=(4*M*l2*pi^2*favg^2)/A2
dE3=E3*((dM/M)^2+(dl2/l2)^2+(dfavg/favg)^2+(dfavg/favg)^2+(dA2/A2)^2)^0.5

%need to do part 2b 

D=importdata('Lab3D.csv'); V=D(:,1); dV=D(:,2); %mV

chip=400; %mV/g
grav=9.81; %m/s^2

xdoubledot=V./chip %g
dxdoubledot=xdoubledot.*(dV./V)

acc=xdoubledot.*grav;
dacc=acc.*(dxdoubledot./xdoubledot);

w=2*pi*favg
dw=w*(dfavg/favg)

x0=acc./-(w.^2)
dx0=x0.*((dacc./acc).^2+2*(dw./w).^2).^0.5

%determining Q of the system

F=importdata('Lab3E.csv'); ht=F(:,1); dht=F(:,2);

Q=pi.*ht.*favg./log(2)
dQ=Q.*((dht./ht).^2+(dfavg./favg).^2).^0.5


end