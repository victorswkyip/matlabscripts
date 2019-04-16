function week1main
x=0:1:5;
y=[0.3,1,2.2,3.7,4,5.9];
dy=[0.1,0.2,0.3,0.4,0.5,0.8];
hold on;
errorbar(x,y,dy,'*');
z=calcvalues(x,y,dy);
A=z(1)
B=z(2)
dA=z(3)
dB=z(4)
plot(x, B*x+A)
title('Sample Weighted Linear Regression Plot');
hold off;
end

function z=calcvalues(x,y,dy)

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

z(1)=A;
z(2)=B;
z(3)=dA;
z(4)=dB;

end


function y=sumelements(x)
sum=0;
for i=1:1:length(x)
    sum=sum+x(i); 
end
y=sum;
end