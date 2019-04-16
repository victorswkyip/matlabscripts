function lab4main
clc;
A=importdata('Lab4A.csv'); varC=A(:,1); f0en2=A(:,2); f0=A(:,3); df0=A(:,4);

df0en2=f0en2.*-2.*(df0./f0);
[b,m,db,dm]=linreg(varC,f0en2,df0en2);
e1=(b+db)+(m+dm).*varC;
e2=(b-db)+(m-dm).*varC;

figure(1)
hold on
plot(varC,f0en2, '*');
plot(varC,f0en2);
legend('Experiment', '1/f_0^2=3.2716*C + 4.6499e-10' ,'Location', 'Northwest');
title('Search for Resonance Frequency with varying Capacitance and R1=51ohms');
xlabel('Capacitance (F)');
ylabel('1/f_0^2 (1/kHz^2)');
hold off
% errorbar(varC, b+m*varC, e1, e2,'*')

L=m/(4*pi^2)
Cs=b/(L*4*pi^2)

B=importdata('Lab4B.csv'); f1=B(:,1); vr1_vt=B(:,2); dvr1_vt=B(:,3); phase1=B(:,4);
C=importdata('Lab4C.csv'); f2=C(:,1); vr12_vt=C(:,2); dvr12_vt=C(:,3);

figure(2)
hold on
errorbar (f1, vr1_vt,dvr1_vt,dvr1_vt, '*')
errorbar (f2, vr12_vt,dvr12_vt,dvr12_vt, '.')
legend('R=R1', 'R=R1+R2' ,'Location', 'Northeast')
title('Shapes of Resonance with Conditions that C=3nF');
xlabel('Frequency (Hz)');
ylabel('V_R/V_T')
hold off

zR1=51;
zR2=180.5;
zC=3e-9;
zf=9830;
zw=zf*2*pi;
zw0=(L*zC)^-0.5;
zf0=zw0/(2*pi);

dzR1=0.002*zR1;
dzR2=0.002*zR2;

zQ=zw0*L/(zR1+zR2);
dzQ=zQ*(dzR1+dzR2)/(zR1+zR2);

A_A0=(1+(zQ^2)*(((zw/zw0)-(zw0/zw))^2))^-0.5;
dA_A0=A_A0*2*(dzQ/zQ);

dI=0.01;
I=0.03296;

xvr=1.681;
dxvr=xvr*((dI/I)^2+(0.002)^2)^0.5;

xvt=7.63;
dxvt=7.63*0.005;

zA=xvr/xvt;
dzA=zA*((dxvr/xvr)^2+(dxvt/xvt)^2)^0.5;

zA0=zA./A_A0;
dzA0=zA0*((dzA/zA)^2+(dA_A0/A_A0)^2)^0.5;

xf1=8200:50:13200;
xw=xf1.*2.*pi;

a=(1+(zQ.^2).*(((xw./zw0)-(zw0./xw)).^2)).^-0.5;
phi=-atand(zQ.*((xw./zw0)-(zw0./xw)));

y1=vr1_vt./zA0;
dy1=y1.*((dvr1_vt./vr1_vt).^2+(dzA0./zA0).^2).^0.5;

figure(3)
hold on
errorbar(log10(f1./zf0),vr1_vt./zA0,dy1,dy1,'*')
plot(log10(xf1./zf0),a)
legend('Experiment', 'Theory', 'Location', 'Northeast');
title('Comparison of Theoretical and Experimental Amplitudes with C=3nF');
xlabel('log_1_0(f/f_0)');
ylabel('(V_R/V_T)/(V_R/V_T)_0')

for i=1:1:length(phase1)
dphase1(i)=3;
end

figure(4)
hold on
errorbar(log10(f1./zf0), phase1,dphase1,dphase1,'*')
plot(log10(xf1./zf0), phi)
legend('Experiment', 'Theory', 'Location', 'Northeast');
title('Comparison of Theoretical and Experimental Phase Shift with C=3nF');
xlabel('log_1_0(f/f_0)');
ylabel('phi (degrees)')
hold off



end