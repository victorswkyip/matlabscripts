function [a, b, c, d]=linreg(x,y,dy)

w=dy.^(-2);
sumw=sumelements(w);
sumwx=sumelements(w.*x);
sumwy=sumelements(w.*y);
sumwxy=sumelements(w.*x.*y);
sumwxx=sumelements(w.*x.*x);

D=sumw*sumwxx-(sumwx)^2; 
A=(sumwxx*sumwy-sumwx*sumwxy)/D;
B=(sumw*sumwxy-sumwx*sumwy)/D;
dA=(sumwxx/D)^(0.5);
dB=(sumw/D)^(0.5);

a=A; %intercept
b=B; %slope
c=dA; %uncertainty in intercept
d=dB; %uncertainty in slope

end


function y=sumelements(x)
sum=0;
for i=1:1:length(x)
    sum=sum+x(i); 
end
y=sum;
end