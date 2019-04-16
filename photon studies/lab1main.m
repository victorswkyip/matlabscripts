function lab1main
clc;
%defining variables for measured quantities first
R=1.40*1000; %resistance in ohms
dR=0.07*1000; %uncertainty in resistance in ohms
C=0.034/1000000; %capacitance in farads 
dC=0.002/1000000; %uncertainty in capacitance in farads

%setting up theoretical data for transfer function
power=1:0.01:5; %make sure data points are evenly distributed
f=10.^power; %defining the array of frequencies (x-axis)
w=f.*(2*pi); %making life easier
y=(1+(w.*R.*C).^2).^-0.5; %magnitude of transfer function (y-axis)
H=@(R,C) (1+(w.*R.*C).^2).^-0.5; 
[dHdR, dHdC]=pder(H,R,dR,C,dC);
dy=((dHdR.*dR).^2+(dHdC.*dC).^2).^0.5; %uncertainty in magnitude of transfer function

%setting up theoretical data for phase shift
z=-atan(w.*R.*C); %phi in radians

G=@(R,C) -atan(w.*R.*C);
[dGdR, dGdC]=pder(G,R,dR,C,dC);
dz=((dGdR.*dR).^2+(dGdC.*dC).^2).^0.5; %uncertainty in phase shift

%seting up measured data
fmeasure=[100 300 1000 3000 10000 30000 100000];
ymeasure=[1 1 .93 .69 .31 .11 .029];
dymeasure=[.04 .04 .03 .03 .03 .01 .001];
zmeasure=[0 -.09 -.31 -.75 -1.3 -1.51 -1.51];
dzmeasure=[0 .09 .03 .09 .1 .09 .06];


%plots
figure(1)
hold on;
semilogx(f,20*log10(y)); %theoretical magnitude of transfer function
plot(f,20*log10(y+dy),':',f,20*log10(y-dy),':'); %error in theoretical magnitude of transfer function

erpos=20*log10(ymeasure+dymeasure)-20*log10(ymeasure);
erneg=20*log10(ymeasure)-20*log10(ymeasure-dymeasure);

errorbar(fmeasure,20*log10(ymeasure),erpos,erneg,'*');
legend('Theory','Plus Uncertainty','Minus Uncertainty','Experiment');
title('Low Pass Filter: Transfer Function Magnitude with R=1.4+/-0.07kOhm, C=0.034+/-0.002uF');
xlabel('Frequency (Hz)');
ylabel('Tranfer Function Magnitude (dB)');
hold off;

figure(2)
hold on;
semilogx(f,z);
plot(f,z+dz,':',f,z-dz,':'); %error in theoretical phase shift angle (degrees)
errorbar(fmeasure,zmeasure,dzmeasure,'*');
legend('Theory','Plus Uncertainty','Minus Uncertainty','Experiment');
title('Low Pass Filter: Phase Shift of Vin and Vout with R=1.4+/-0.07kOhm, C=0.034+/-0.002uF');
xlabel('Frequency (Hz)');
ylabel('Phase Shift Angle (rad)');
hold off;
end
