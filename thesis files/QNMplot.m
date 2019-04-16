clc; clear all;  close all;

e0 = 1/(36*pi)*1e-9; %[C^2/Nm^2]
c = 2.98e8; %[m/s]
n = 1.5; %refractive index in figure 1a
f_m = 0; %non-dispersive media
w_m = 2.04574343894687e+15 + 104487640465493i; %eigenfrequency OR pole calculated by comsol server matlab using drude model...

% w=2*pi*c./(0.7e-6:0.01e-6:1.2e-6);

r0 = 10e-9; %origin of the source relative to the origin
J=[0 ; 0; 1]; %current is kronecker delta in the z direction
magJ=norm(J(r, r0));%sqrt(sum(J(r,r0).*J(r,r0)));

Enorm=[-3.148572033973699e+12 - 1.158419038423001e+13i;
    -2.338225251700153e+12 - 7.860856063131686e+12i;
    -7.733414853010841e+15 + 1.522831542482067e+14i]; %Used to calculate coupling coefficient

int=dot(J(r0,r0),Enorm);

Psi_s=[1.711724820219455e+19 - 5.980152230605488e+18i;
    1.159398322778564e+19 - 4.361859126712599e+18i;
    -1.054813433060611e+21 - 1.163527675657386e+22i]; %I guessed that this was the Scattered E field. Not sure though

a=@(w) (i*int)/(w-w_m)+f_m; %coupling coefficient. Eq 3 of optics express
Psi_qnm= @(w) (sqrt((w_m-w)/(-i*dot(J(r0,r0),Psi_s))))*Psi_s; %were good up till here


factor1=@(w) (-6*pi*e0*c*c*c)./((w.*w)*n*1);
factor2= @(w) real(dot(conj(J(r0,r0)),Psi_qnm(w)));
P=@(w) factor1(w).*factor2(w); %Purcell factor

% for w=2*pi*c/0.7e-6:-2*pi*c/0.01e-6:2*pi*c/1.2e-6
% for w=2.6748e+15:-1114500000000: 1.5603e+15    
%     hold on
%     figure(1)
%     plot(w,P(w),'.')
% end
% hold off