function [m,b,dm,db]=linreg(x,y,dy)
w=dy.^-2;
wx=w.*x;
wy=w.*y;
wxx=w.*x.*x;
wxy=w.*x.*y;
D=sumele(w)*sumele(wxx)-(sumele(wx)).^2;
A=(sumele(wxx)*sumele(wy)-sumele(wx)*sumele(wxy))/D;
B=(sumele(w)*sumele(wxy)-sumele(wx)*sumele(wy))/D;
dA=(sumele(wxx)/D)^0.5;
dB=(sumele(w)/D)^0.5;
m=B;
b=A;
dm=dB;
db=dA;
end