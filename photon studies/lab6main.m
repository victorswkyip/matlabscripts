function lab6main
clc;
A=importdata('Lab6A.csv'); V1=A(:,5); dV1=A(:,2); I1=A(:,6); dI1=A(:,4);
B=importdata('Lab6B.csv'); V2=B(:,5); dV2=B(:,2); I2=B(:,6); dI2=B(:,4);
C=importdata('Lab6C.csv'); V3=C(:,5); dV3=C(:,2); I3=C(:,6); dI3=C(:,4);
D=importdata('Lab6D.csv'); V4=D(:,5); dV4=D(:,2); I4=D(:,6); dI4=D(:,4);

rad1=0.08/2;
drad1=0.002;
rad2=0.1/2;
drad2=0.002;

R=0.154;
dR=0.005;
K=7.73e-4;
dK=0.04e-4;

bB1=0.997438;
bB2=0.994067;

Kr1=bB1*K
Kr2=bB2*K

I_l1=I2./1000;
I_s1=I1./1000;

I_l2=I3./1000;
I_s2=I4./1000;

B_T1=(Kr1/2).*(I_l1+I_s1)
B_T2=(Kr2/2).*(I_l2+I_s2)

B_E1=(Kr1/2).*(I_l1-I_s1)
B_E2=(Kr2/2).*(I_l2-I_s2)

emr1=(2.*((V1+V2)./2))./((B_T1.^2).*(rad1.^2))
emr2=(2.*((V4+V3)./2))./((B_T2.^2).*(rad2.^2))

B_Tav1=mean(B_T1)
B_Tav2=mean(B_T2)
B_Eav1=mean(B_E1)
B_Eav2=mean(B_E2)

emr1av=mean(emr1)

emr2av=mean(emr2)

acceptedemr=1.76e11
acceptedBe=54101.9e-9

%Calculate K

u0=(4*pi)*10^-7
n=130
b=0.15/2

B0=(u0.*n.*(I1./1000).*R^2)./((R^2+b^2)^(3/2))

K=B0./(I1./1000)

Kav=mean(K)




end