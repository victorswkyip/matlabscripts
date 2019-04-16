function lab2main
%part 1a)
clc;
%defining measured quantities
L=10/1000; %inductance
dL=0.005*L; %uncertainty of inductance
C=0.455/1000000; %capacitance
dC=0.005*C; %uncertainty of capacitance
RL=25; %resistance of inductor
dRL=0.002*RL; %uncertainty of resistance of inductor
%import data from excel file
C=importdata('lab2tableA.csv'); f=C(:,1); vrms=C(:,2); dvrms=C(:,3); irms=C(:,4)./1000; dirms=C(:,5)./1000;
%definig the range of frequency values that were sampled for the experiment
w=(2*pi).*f;
w2=w.^2; 

%calculating impedance, impedance^2, their uncertainties, omega, and omega^2
zL=(vrms./irms)
zL2=zL.^2; 
dzL=zL.*((dvrms./vrms)+(dirms./irms)); %calculated uncertainty in impedance
dzL2=zL2.*(2.*(dzL./zL)); %uncertainty in impedance squared
[b,m,db,dm]=linreg(w2,zL2,dzL2); %intercept, slope, uncertainty in intercept, uncertainty in slope

%calculate R_L and L theoretically based on the line from measurements
RL_th=b^0.5
dRL_th=RL_th*0.5*(db/b)
L_th=m^0.5
dL_th=L_th*0.5*(dm/m)

%plotting
hold on;
figure(1);
plot(w2,zL2,'*'); %experiment
plot(w2,(m+dm)*w2+(b+db),':', w2,(m-dm)*w2+(b-db),':'); %uncertainties
legend('Experiment: Z^2=1.0218e-04*w^2+710.4256', 'Experimental Upper Uncertainty', 'Experimental Lower Uncertainty', 'Location', 'Southeast');
title('Impedance of an Inductor');
xlabel('Omega^2 (rad^2/s^2)');
ylabel('Impedance^2 (kOhm^2)');
hold off;


%part 1b

B=importdata('lab2tableB.csv'); f_=B(:,1); vrms_=B(:,2); dvrms_=B(:,3); irms_=B(:,4)./1000; dirms_=B(:,5)./1000;
%definig the range of frequency values that were sampled for the experiment
w_=(2*pi).*f_;
w2_=w_.^-2;

%calculating impedance, impedance^2, their uncertainties, omega, and omega^2
zC_=(vrms_./irms_)
zC2_=zC_.^2;
dzC_=zC_.*((dvrms_./vrms_)+(dirms_./irms_)); %calculated uncertainty in impedance
dzC2_=zC2_.*(2.*(dzC_./zC_)); %uncertainty in impedance squared
[b_,m_,db_,dm_]=linreg(w2_,zC2_,dzC2_); %intercept, slope, uncertainty in intercept, uncertainty in slope

%calculate R_C and C theoretically based on the line from measurements
RC_th=b_^0.5
dRC_th=RC_th*0.5*(db_/b_)
C_th=m_^-0.5
dC_th=C_th*0.5*(dm_/m_)


hold on;
figure(2);
plot(w2_,zC2_,'*');%experiment
hold off;
hold on;
plot(w2_,(m_+dm_)*w2_+(b_+db_),':', w2_,(m_-dm_)*w2_+(b_-db_),':'); %uncertainties
legend('Experiment: Z^2=4.5009e+12*w^-2+2.5416e+03', 'Experimental Upper Uncertainty', 'Experimental Lower Uncertainty', 'Location', 'Southeast');
title('Impedance of a Capacitor');
xlabel('1/Omega^2 (s^2/rad^2)');
ylabel('Impedance^2 (kOhm^2)');
hold off;


%part B

C=importdata('lab2tableC.csv'); vp=C(:,1); ip=C(:,2)./1000; vs=C(:,3); is=C(:,4)./1000;

dvp=0.005.*vp;
dip=0.0075.*ip;
dvs=0.005.*vs;
dis=0.0075.*is;

[aa,bb,cc,dd]=linreg(ip,vp,dvp)

[aaa,bbb,ccc,ddd]=linreg(is,vs,dvs)

hold on;
figure(3)
plot(ip,vp,'*');
hold off;
hold on;
plot(ip,(bb+dd).*ip+(aa+cc),':',ip,(bb-dd).*ip+(aa-cc),':')
legend('V=82.9108*I+0.0033','Experimental Upper Uncertainty', 'Experimental Lower Uncertainty','Location', 'Southeast');
title('The Equivalent Impedance of a Inductor and Capacitor in Parallel at f=1000Hz');
xlabel('Current (A)');
ylabel('Voltage (V)');
hold off

hold on;
figure(4)
plot(is,vs,'*');
hold off
hold on
plot(is,(bbb+ddd).*is+(aaa+ccc),':',is,(bbb-ddd).*is+(aaa-ccc),':')
legend('V=286.2436*I+0.0382', 'Experimental Upper Uncertainty', 'Experimental Lower Uncertainty','Location', 'Southeast');
title('The Equivalent Impedance of a Inductor and Capacitor in Series at f=1000Hz');
xlabel('Current (A)');
ylabel('Voltage (V)');
hold off;

%partC
w_test=1000*2*pi
ZL=RL_th+j*w_test*L_th
ZC=1/(j*w_test*C_th)
dZL=dRL_th+j*w_test*dL_th
dZC=(j*w_test*dC_th)
Zp=1/(1/ZL+1/ZC)
magZp=abs(Zp)
Zs=ZL+ZC
magZs=abs(Zs)
%partD
IL=vp./ZL;
magIL=abs(IL)
IC=vp./ZC;
magIC=abs(IC)
%part E
VL=is.*ZL;
magVL=abs(VL)
VC=is.*ZC;
magVC=abs(VC)
end