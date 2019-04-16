function main
clear all
clc


A=importdata('lab7data.csv'); Vs_Iron_variac=A(:,1)./1000; dVs_Iron_variac=A(:,2)./1000; Vc_Iron_variac=A(:,3)./1000; dVc_Iron_variac=A(:,4)./1000;



u0=1.25663706e-6;

% fluxdensity=u0*220.5

second_iron = csvread('PRINT_00.csv',0,0,[0,0,667,0]); 
Vs_Iron = csvread('PRINT_00.csv',0,1,[0,1,667,1]);
Vc_Iron = csvread('PRINT_00.csv',0,2,[0,2,667,2]);

second_steel = csvread('PRINT_01.CSV',0,0,[0,0,667,0]); 
Vs_Steel = csvread('PRINT_01.CSV',0,1,[0,1,667,1]);
Vc_Steel = csvread('PRINT_01.CSV',0,2,[0,2,667,2]);

second_iron_plastic = csvread('PRINT_04.CSV',0,0,[0,0,667,0]); 
Vs_Iron_plastic = csvread('PRINT_04.CSV',0,1,[0,1,667,1]);
Vc_Iron_plastic = csvread('PRINT_04.CSV',0,2,[0,2,667,2]);

second_iron_copper = csvread('PRINT_05.CSV',0,0,[0,0,667,0]);
Vs_Iron_copper = csvread('PRINT_05.CSV',0,1,[0,1,667,1]);
Vc_Iron_copper = csvread('PRINT_05.CSV',0,2,[0,2,667,2]);

% intecept=findint(Vs_Steel);


N_iron = length(second_iron);
N_steel = length(second_steel);


T_iron = abs(second_iron(1)-second_iron(N_iron));
f_iron = 1/T_iron

T_steel = abs(second_steel(1)-second_steel(N_steel));
f_steel = 1/T_steel

n1=160;
n2=150;

S=0.1;
dS= 0.05*S;

R=1e6;
dR=0.01*R;

C=0.5e-6;
dC=0.02*C;

Hexp_iron=@(L_steel,S) (n1./(L_steel*S));
Hexp_steel=@(L_steel,S) (n1./(L_steel*S));
H_exp=@(L_iron,Vs_Iron_variac,S) (n1./(L_iron*S)).*Vs_Iron_variac;

Bexp_steel=@(Ac_steel,R,C) ((R*C)/(n2*Ac_steel));
Bexp_iron=@(Ac_iron,R,C) (R*C)/(n2*Ac_iron);
B_exp=@(Ac_iron,Vc_Iron_variac,S) ((R*C)/(n2*Ac_iron)).*Vc_Iron_variac;

u_r=@(B,H) ( B ./(H*u0));


L_steel = 72.1e-3; %***
dL_steel = ((0.1/1000)^2 + (0.1/1000)^2)^(0.5);

L_iron = 72.1e-3; %***
dL_iron = ((0.1/1000)^2 + (0.1/1000)^2)^(0.5)

Ac_steel=(29.9e-3)*(27.5e-3) %****
dAc_steel=((0.1e-3)/(29.9e-3) + (0.1e-3)/(27.5e-3)) * Ac_steel;

Ac_iron = (30.4e-3)*(29.0e-3); %****
dAc_iron=((0.1e-3)/(30.4e-3) + (0.1e-3)/(29.0e-3)) * Ac_iron

V_iron = L_iron * Ac_iron
dV_iron =((dAc_iron/Ac_iron) + (dL_iron/L_iron))*V_iron;

V_steel = L_steel * Ac_steel
dV_steel =((dAc_steel/Ac_steel) + (dL_steel/L_steel))*V_steel

H_steel=Hexp_steel(L_steel,S);
H_steel=H_steel.*Vs_Steel;
dH_steel=errorprop(Hexp_steel,L_steel,dL_steel,S,dS);
dH_steel=dH_steel.*abs(Vs_Steel);

H_iron=Hexp_iron(L_iron,S);
H_iron=H_iron.*Vs_Iron;
dH_iron=errorprop(Hexp_iron,L_iron,dL_iron,S,dS);
dH_iron=dH_iron.*abs(Vs_Iron);

B_steel=Bexp_steel(Ac_steel,R,C);
B_steel=B_steel.*Vc_Steel;
dB_steel=errorprop(Bexp_steel,Ac_steel,dAc_steel,R,dR,C,dC);
dB_steel=0.04324520595.*abs(Vc_Steel);


B_iron=Bexp_iron(Ac_iron,R,C);
B_iron=B_iron.*Vc_Iron;
dB_iron=errorprop(Bexp_iron,Ac_iron,dAc_iron,R,dR,C,dC);
dB_iron=0.08538649.*abs(Vc_Iron);


H_iron_variac=H_exp(L_iron,Vs_Iron_variac,S)
dH_iron_variac=errorprop(H_exp,L_iron,dL_iron,Vs_Iron_variac,dVs_Iron_variac,S,dS);

B_iron_variac=B_exp(Ac_iron,Vc_Iron_variac,S)
dB_iron_variac=errorprop(B_exp,Ac_iron,dAc_iron,Vc_Iron_variac,dVc_Iron_variac,S,dS);

 figure(1)
 plot(H_iron_variac,B_iron_variac)
 title('Initial Magnetization Curve of Iron')
 xlabel('Magnetizing Force (A/m)')
 ylabel('Magnetic Field (T)')


u_r_iron=u_r(B_iron_variac,H_iron_variac)
dur_iron = errorprop(u_r,B_iron_variac,dB_iron_variac,H_iron_variac,dH_iron_variac)

 figure(2)
 plot(H_iron_variac,u_r_iron);
 title('Relative Permeability for an Iron Sample')
 xlabel('Magnetizing Force (A/m)')
 ylabel('Relative Permeability')

    H_iron_smallest = 1e9;
    B_iron_smallest = 1e9;
int1=1;
for i=1:N_iron
    

    if abs(H_iron(i))<abs(H_iron_smallest) && B_iron(i) > 0
        
        H_iron_smallest = H_iron(i);
        Remanence_iron = B_iron(i);
    int1=i;
    end
end
Remanence_iron
int2=1;

    B_iron_smallest = 1e9;
    
for j=1:N_iron
      
    
    if abs(B_iron(j)) < abs(B_iron_smallest) && H_iron(j) < 0
        B_iron_smallest = B_iron(j);
        Coercive_iron = H_iron(j);
        int2=j;
    end
end
Coercive_iron
int3=1;

    H_steel_smallest = 1e9;
for n=1:N_steel
    

    if abs(H_steel(n))<abs(H_steel_smallest) && B_steel(n) > 0
        
        Remanence_steel = B_steel(n);
    int3=n;
    end
end
Remanence_steel
int4=1;

    B_steel_smallest = 1e9;

for m=1:N_steel;
      
    if abs(B_steel(m)) < abs(B_steel_smallest) && H_steel(m) < 0
        B_steel_smallest = B_steel(m);
        Coercive_steel = H_steel(m);
    int4=m;
    end
end
Coercive_steel

 figure(3)
 plot(H_iron,B_iron,H_steel,B_steel,'.')
 legend('Transformer Iron Sample', 'Carbon Steel Sample', 'Location', 'Northwest')
 title('Hysteresis Loops for Transformer Iron and Carbon Steel Samples')
 xlabel('Magnetizing Force (A/m)')
 ylabel('Magnetic Field (T)')


% Integrate for volume ?
int_iron=integral_trap(H_iron,B_iron);
int_steel=integral_trap(H_steel,B_steel)

P_iron=int_iron * f_iron * V_iron
dP_iron = (dV_iron/V_iron)*P_iron

P_steel=int_steel * f_steel * V_steel
dP_steel = (dV_steel/V_steel)*P_steel


H_iron_plastic=Hexp_iron(L_iron,S);
H_iron_plastic=H_iron_plastic.*Vs_Iron_plastic;


B_iron_plastic=Bexp_iron(Ac_iron,R,C);
B_iron_plastic=B_iron_plastic.*Vc_Iron_plastic;

int_iron_plastic=integral_trap(H_iron_plastic,B_iron_plastic);

P_iron_plastic = int_iron_plastic * f_iron * V_iron
 
 figure(4)
 plot(H_iron_plastic,B_iron_plastic)
 title('Hysteresis Loop of Iron Affected by Plastic Spacer')
 xlabel('Magnetizing Force (A/m)')
 ylabel('Magnetic Field (T)')

H_iron_copper=Hexp_iron(L_iron,S);
H_iron_copper=H_iron_copper.*Vs_Iron_copper;


B_iron_copper=Bexp_iron(Ac_iron,R,C);
B_iron_copper=B_iron_copper.*Vc_Iron_copper;

int_iron_copper=integral_trap(H_iron_copper,B_iron_copper);

P_iron_copper = int_iron_copper * f_iron * V_iron

figure(5)
 plot(H_iron_copper,B_iron_copper)
 
 title('Hysteresis Loop of Iron Affected by Copper Spacer')
 xlabel('Magnetizing Force (A/m)')
 ylabel('Magnetic Field (T)')

end
function dy=errorprop(f,a,da,b,db,c,dc)

p=nargin(f);

if (p==1)
    dy=sqrt(((a.*da).^2));
    
else if (p==2)
        dy=sqrt(((a.*da).^2)+((b.*db).^2));
        
    else if (p==3)
            dy=sqrt(((a.*da).^2)+((b.*db).^2)+((c.*dc).^2));
        end
        
    end
end

end
function int=integral_trap(x,y)



N=length(x);
int=0;
for n=1:1:N-1
    
    h(n)=x(n)-x(n+1);
   
    
    int=int+((y(n))+(y(n+1)))/2 .* h(n);
    
end
end