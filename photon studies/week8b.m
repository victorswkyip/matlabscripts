function week8b
N=400;
fn=90;
T=2;
t=0:T/N:T-T/N;
f0=1/T;

win=tukeywin(N)';
v=pulse(N);
vn=10*cos(2*pi*90.*t);
vs=(v+vn).*win;
VS=fft(vs);
kmax=floor(N/2)
fp=[0:kmax];

if N/2==kmax
    fn=[-kmax+1:-1];
    f=f0*[fp,fn];
else
    fn=[-kmax:-1];
    f=f0*[fp,fn];
end

H=lowpass(f);
VL=VS.*H;
vl=ifft(VL);

figure(2)
plot(t,real(vl))
title('Signal after Butterworth Filter')
xlabel('Time')
ylabel('Amplitude [V]')
end

function H=lowpass(f)
Rs=50; %Ohm
L=2.63; %H
C=4.35*10^(-4); %F
RL=50; %Ohm

Zc=1./(2j.*pi.*f.*C);
ZL=2j.*pi.*f.*L;
Zc_RL=Zc.*RL./(Zc+RL);

H=Zc_RL./(Rs+ZL+Zc_RL);
H(1)=0.5;
end

function [v] = pulse(N)
n=(0:N-1)/N;
v=sin(2*pi*8*n).*(0.5+0.5*cos(2*pi*n+pi)).^3;
end