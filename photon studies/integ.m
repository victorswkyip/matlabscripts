function integ

f=@(x) x.^2;
N=3;
h=(xb-xa)/(2*N)
X=xa:h:xb
Nx=length(X)

w=ones(Nx,1)

w(2:1:Nx-1)
w(2:2:Nx-1)

integ=f(X)*w*h/3


end