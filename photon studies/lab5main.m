function lab5main
clc;
A=importdata('datafile1.csv'); vang1=A(:,1); vamp1=A(:,2);
B=importdata('datafile2.csv'); vang2=B(:,1); vamp2=B(:,2);
C=importdata('datafile3.csv'); vang3=C(:,1); vamp3=C(:,2);
D=importdata('datafile4.csv'); vang4=D(:,1); vamp4=D(:,2);
E=importdata('datafile5.csv'); vang5=E(:,1); vamp5=E(:,2); ang5=E(:,3); %noise

%y = -0.0133x + 2.6467 - this is the angle conversion equation where
%y=vang, x =angle


ang1=(vang1-2.6467)./-0.0133;
ang2=(vang2-2.6467)./-0.0133;
ang3=(vang3-2.6467)./-0.0133;
ang4=(vang4-2.6467)./-0.0133;

amp1=vamp1.^2;
amp2=vamp2.^2;
amp3=vamp3.^2;
amp4=vamp4.^2;
amp5=vamp5.^2; %noise

vamp1

max1=max(vamp1)
max2=max(vamp2)
max3=max(vamp3)
max4=max(vamp4)

t_amp1=max1/6
t_amp2=max2/4
t_amp3=max3/2
t_amp4=max4/1


%theoretical calculations


theta=-50:0.5:50;


T=23;
dT=1;
f=39960;
v=331.4+0.6*T;
lambda=v/f;
b=0.00951;
k=(2*pi)/lambda;
d=2.8;
beta=k.*d.*sind(theta);

k=(2*pi)/lambda;
phi=k.*b.*sind(theta);

AA1=(t_amp1^2).*((sin(phi/2)).^2./(phi/2).^2).*((sind(6*beta/2)).^2./(sind(beta/2)).^2); 
AA2=(t_amp2^2).*((sin(phi/2)).^2./(phi/2).^2).*((sind(4*beta/2)).^2./(sind(beta/2)).^2); 

AA3=(t_amp3^2).*((sin(phi/2)).^2./(phi/2).^2).*((sind(2*beta/2)).^2./(sind(beta/2)).^2); 


AA4=(t_amp4^2).*((sin(phi/2)).^2./(phi/2).^2); %1slit



figure(1)
hold on
plot(ang1-2,amp1,':')
plot(theta,AA1,'r')
title('Amplitude vs Angle With 6 Exposed Slits')
xlabel('Theta (degrees)')
ylabel('Amplitude (V^2)')
legend('Experimental', 'Theoretical')
hold off

figure(2)
hold on
plot(ang2-2,amp2,':')
plot(theta,AA2,'r')
title('Amplitude vs Angle With 4 Exposed Slits')
xlabel('Theta (degrees)')
ylabel('Amplitude (V^2)')
legend('Experimental', 'Theoretical')
hold off

figure(3)
hold on
plot(ang3-2,amp3,':')
plot(theta,AA3,'r')
title('Amplitude vs Angle With 2 Exposed Slits')
xlabel('Theta (degrees)')
ylabel('Amplitude (V^2)')
legend('Experimental', 'Theoretical')
hold off

figure(4)
hold on
plot(ang4,amp4,':')
plot(theta,AA4,'r')
title('Amplitude vs Angle With 1 Exposed Slit')
xlabel('Theta (degrees)')
ylabel('Amplitude (V^2)')
legend('Experimental', 'Theoretical')
hold off

figure(5)
hold on
plot(ang4,amp4.^0.5,':')
plot(ang5,amp5.^0.5,'r')
title('Noise Data compared with Single Slit Data')
xlabel('Theta (degrees)')
ylabel('Amplitude (V)')
legend('Single Slit', 'Noise')
hold off


end