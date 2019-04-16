function simptest
N=10;
xb=1; xa=0;
yb=2; ya=0;

h=(xb-xa)/(2*N);
hy=(yb-ya)/(2*N);

int=0;
for y=ya+hy:2*hy:yb-hy
    int=int+(f(xb-xa,y-h)+4*f(xb-xa,y)+f(xb-xa,y+h))*h/3;
end
int
int2=0;
for x=xa+h:2*h:xb-h
    int2=int2+(f(x-h,int)+4*f(x,int)+f(x+h,int))*h/3;
end
int2
ans=int+int2
end

function z=f(x,y)
z=(x.^2).*y;
end