function lab8main
clc;

%mechanical system underdamped
nocycles=3;
time1=23.03;
dtime1=0.1;
time2=23.22;
dtime2=0.1;
times=[time1, time2];

dmean=dtime1+dtime2;

period= mean(times)/nocycles; %seconds
dperiod=period*(dmean/mean(times))

%i)
w=(2*pi)/period %rad/s
dw=w*(dperiod/period)

%ii)

A=importdata('Lab8A.csv'); t=A(:,1); x=A(:,2);
dx=0.4;
X=@(x) log(x);
XX=log(x);
dX=erprop(X,x,dx);

[b,m,db,dm]= linreg(t,XX,dX);
%no clue why ^ these values are being displayed in polar form so i
%corrected for that
b=abs(b)
m=-abs(m)
db=abs(db)
dm=abs(dm)

y=2*m
dy=y*(dm/m)

w0=((w^2)+(y/2)^2)^0.5
W0=@(w,y) ((w^2)+(y/2)^2)^0.5;
dw0=erprop(W0,w,dw,y,dy)

figure(1)
hold on;
plot(t,log(x),'*')
plot(t,m*t+b)
legend('experimental data', 'x=-0.2103t+3.9838')
title('Underdamped Behaviour of Mechanical System')
xlabel('time (s)')
ylabel('amplitude (units)')
hold off


%electrical system underdamped

%i)
T1=72.8e-6-35.4e-6;
dT1=2e-6;
T2=35.4e-6+2e-6;
dT2=2e-6;
Tmean=(T1+T2)/2
dTmean=dT1+dT2

omega=(2*pi)/Tmean
domega=omega*(dTmean/Tmean)

%ii)

B=importdata('Lab8B.csv'); t_=B(:,1); x_=B(:,2); dx_=B(:,3);


[b_,m_,db_,dm_]= linreg(t_,log(x_),dx_)

gamma=2*m_
dgamma=gamma*(dm_/m_)

w0_=((omega^2)+(gamma/2)^2)^0.5
W0_=@(omega,gamma) ((omega^2)+(gamma/2)^2)^0.5;
dw0_=erprop(W0_,omega,domega,gamma,dgamma)


figure(2)
hold on
plot(t_,log(x_),'*')
plot(t_,m_*t_+b_)
legend('experimental data', 'V=-1.5335e+04t+2.3362')
title('Underdamped Behaviour of Electrical System')
xlabel('time (s)')
ylabel('amplitude (volts)')
hold off
hold off

%iii)

L=25.6e-3; %H
R=140; %ohm
C=1150e-12; %F

RL=145;
RV=1;
RG=580;

RT=RL+RV+RG

gamma_T=RT/L

w0_T=((omega^2)+(gamma_T/2)^2)^0.5

w0_T2=(L*C)^-0.5


%electrical critical damping

RV2=7800;
dRV2=200;

RT2=RL+RV2+RG

R_required=(4*L/C)^0.5

AA=importdata('PRINT_12.csv'); tAA=AA(:,1); vAA=AA(:,2); %underdamped
BB=importdata('PRINT_13.csv'); tBB=BB(:,1); vBB=BB(:,2); %critical dammped
CC=importdata('PRINT_14.csv'); tCC=CC(:,1); vCC=CC(:,2); %overdamped

figure(3)
hold on;

plot(tAA,vAA, '.')
plot(tBB,vBB, ':')
plot(tCC,vCC)
legend('underdamped', 'critically damped' , 'overdamped')
title('Comparision of Decay Graphs from Oscilloscope')
xlabel('time (s)')
ylabel('amplitude (volts)')

hold off;

end