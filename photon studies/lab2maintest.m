function lab2main
clc;
%defining measured quantities
L=10/1000; %inductance
dL=0.005*L; %uncertainty of inductance
C=0.455/1000000; %capacitance
dC=0.005*C; %uncertainty of capacitance
RL=25; %resistance of inductor
dRL=0.002*RL; %uncertainty of resistance of inductor
%import data from excel file
A=importdata('lab2tables.csv'); f=A(:,1); vrms=A(:,2); dvrms=A(:,3); irms=A(:,4)./1000; dirms=A(:,5)./1000;

%calculate theoretical values
w=(2*pi).*f 
w2=w.^2 
zL2_th=RL^2+(w.*L).^2
H=@(RL,L) RL^2+(w.*L).^2
[dHdRL, dHdL]=pder(H,RL,dRL,L,dL)
dzL2_th=((dHdRL.*dRL).^2+(dHdL.*dL).^2).^0.5 %uncertainty in magnitude of transfer function

%calculating impedance, impedance^2, their uncertainties, omega, and omega^2
zL=(vrms./irms) 
zL2=zL.^2 
dzL=zL.*((dvrms./vrms)+(dirms./irms)) %calculated uncertainty in impedance
dzL2=zL2.*(2.*(dzL./zL)) %uncertainty in impedance squared
[b,m,db,dm]=linreg(w2,zL2,dzL2) %intercept, slope, uncertainty in intercept, uncertainty in slope

%calculate RL, X, and L theoretically based on the line from measurements
RL_th=b^0.5
dRL_th=RL_th*(2*db/b)
XL=(zL2-RL_th).^0.5
dXL=XL.*(2.*(dzL2+dRL_th)./(zL2-RL_th))
L_th=XL./w
dL_th=L_th.*(dXL./XL)

%plotting
hold on;
errorbar(w2,zL2_th, dzL2_th,'*') %theory
plot(w2,zL2) %experiment
plot(w2,(m+dm)*w2+(b+db),':', w2,(m-dm)*w2+(b-db),':') %uncertainties
legend('Theory', 'Experiment - Z^2=1.0218e-04*w^2+710.4256', 'Experimental Upper Uncertainty', 'Experimental Lower Uncertainty', 'Location', 'Southeast')
title('Impedance of an Inductor assuming R_L=25ohms+/-0.5%, L=10mH+/-0.5%');
xlabel('Omega^2 (rad^2/s^2)')
ylabel('Impedance^2 (kOhm^2)')
hold off;

% hold on;
% figure(2);
% plot(w2,zL2_th)
% % plot(w2,(m+dm).*w2+(b+db), ':')
% % plot(w2,(m-dm).*w2+(b-db), ':')
% % plot(w2,
% errorbar (w2,zL2, dzL2, '*')
% hold off;

end