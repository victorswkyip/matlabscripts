function question3

%initialze values

m=1.5;
Is=2.11e-10; %A
Vt=25.3e-3; %V

t=0:1e-5:0.04;
step=1e-5;

R=1000;
C=50e-6;

Vs(1)=10*sin(2*pi*60);
Vc(1)=step*((Is/C)*(exp((Vs(1))/(m*Vt))-1));

for i=1:1:length(t)-1
    Vs(i+1)=10.*sin(2.*pi.*60.*t(i));
    Vc(i+1)=step.*((Is./C).*(exp((Vs(i)-Vc(i))/(m.*Vt))-1)-(Vc(i)./(C.*R)))+Vc(i);
end

Vd=Vs-Vc

Id=Is*(exp(Vd/(m*Vt))-1);


hold on;
figure(1)
plot(t,Vs,'k',t,Vc,'r')
legend('Vs', 'Vc')
xlabel('time (s)')
ylabel('Voltage (V)')
hold off;

hold on
figure(2)
plot(t,Id)
legend('Id')
xlabel('time (s)')
ylabel('Current (V)')
hold off


end