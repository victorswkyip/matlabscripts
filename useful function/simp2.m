function simp2
Nx=2; Ny=1;
xb=1; xa=0;
yb=2; ya=0;

h=(xb-xa)/(2*Nx);
hy=(yb-ya)/(2*Ny);

int=0;
int2=0;
for y=ya+hy:2*hy:yb-hy
    int=int+(f(xb-xa,y-h)+4*f(xb-xa,y)+f(xb-xa,y+h))*hy/3;
    
    for x=xa+h:2*h:xb-h
        int2=int2+(f(x-h,int)+4*f(x,int)+f(x+h,int))*h/3;
    end
end
int
int2
ans=int+int2
end

function z=f(x,y)
z=(x.^2).*y;
end