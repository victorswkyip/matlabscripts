function lab7main
clc;
A=importdata('PRINT_00.csv'); time1=A(:,1); vs1=A(:,2); vc1=A(:,3); 
B=importdata('PRINT_01.csv'); time2=B(:,1); vs2=B(:,2); vc2=B(:,3);
C=importdata('PRINT_04.csv'); time3=C(:,1); vs3=C(:,2); vc3=C(:,3);
D=importdata('PRINT_05.csv'); time4=D(:,1); vs4=D(:,2); vc4=D(:,3);

n1=160;
n2=150;

S=0.10; %ohm
dS=0.05*S;

L=72.1/1000 ; %m
dL=0.1/1000;

R=1e6; %ohm
C=0.5e-9; %F

A_iron=0.0008816; %m^2
A_steel=0.00082225;

H_iron=(n1/(L*S)).*vs1;
H_steel=(n1/(L*S)).*vs2;

H_ironav=mean(H_iron)
H_steelav=mean(H_steel)

B_iron=((R*C)/(n2*A_iron)).*vc1;
B_steel=((R*C)/(n2*A_steel)).*vc2;

B_ironav=mean(B_iron)
B_steelav=mean(B_steel)

figure(1)
hold on
plot(H_iron,B_iron)
plot(H_steel,B_steel,'.')
title('Ferromagnetic Hysteresis Loop of Carbon Steel and Iron with L=72.1+/-0.1 mm')
xlabel('Coercive Force, H (A/m)')
ylabel('Magnetic Field, B (T)')
legend('Iron Hysteresis Loop','Carbon Steel Hysteresis Loop', 'Location', 'Northwest')
hold off


for i=1:1:length(vs1)-1
    h(i)=vs1(i+1)-vs1(i)
    if h(i)<0
        areatop(i)=(h(i)./2).*(vc1(i+1)+vc1(i))
    elseif h(i)>0
        areabot(i)=(h(i)./2).*(vc1(i+1)+vc1(i))
    end
end
atopcurve=sumelements(-areatop)
abotcurve=sumelements(areabot)

area=atopcurve-abotcurve



end