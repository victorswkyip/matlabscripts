function week10

step=1
xstart=0; xstop=40;
ystart=0; ystop=40;

x=xstart:step:xstop;
y=ystart:step:ystop;

Nx=length(x);
Ny=length(y);
V(1:Ny,1:Nx)=0;

V(:,1)=0; V(:,Nx)=0;
V(1,:)=0; V(Ny,:)=0;

V(26,11:31)=10;
V(16,11:31)=-10;

for i=1:100
    for n=2:Ny-1
        for m=2:Nx-1
            if (n==16 && (m==11||m==12||m==13||m==14||m==15||m==16||m==17||m==18||m==19||m==20||m==21||m==22||m==23||m==24||m==25||m==26||m==27||m==28||m==29||m==30||m==31))
                V(n,m)=-10
            elseif (n==26 && (m==11||m==12||m==13||m==14||m==15||m==16||m==17||m==18||m==19||m==20||m==21||m==22||m==23||m==24||m==25||m==26||m==27||m==28||m==29||m==30||m==31))
                V(n,m)=10
            else
                V(n,m)=1/4*(V(n-1,m)+V(n+1,m)+V(n,m-1)+V(n,m+1));
            end
        end
    end
end
        
    hold on
    contour(V,11)
    [Ex,Ey]=gradient(V)
    quiver(-Ex,-Ey)
    hold off
    
end