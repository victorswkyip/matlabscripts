function simp3
N=10;
xb=5; xa=0;
yb=2; ya=0;
zb=1; za=0;

h=(xb-xa)/(2*N);
hy=(yb-ya)/(2*N);
hz=(zb-za)/(2*N);

int3=0;
for z=za+hz:2*hz:zb-hz
    int3=int3+(f(xb-xa,yb-ya,z-hz)+4*f(xb-xa,yb-ya,z)+f(xb-xa,yb-ya,z+h))*hz/3;
end
int3

int=0;
for y=ya+hy:2*hy:yb-hy
    int=int+(f(xb-xa,y-h, int3)+4*f(xb-xa,y, int3)+f(xb-xa,y+h,int3))*hy/3;
end
int
int2=0;
for x=xa+h:2*h:xb-h
    int2=int2+(f(x-h,int,int3)+4*f(x,int,int3)+f(x+h,int,int3))*h/3;
end
int2
ans=int+int2+int3
end

function C=f(x,y,z)
C=(x.*z)./(1+y);
end