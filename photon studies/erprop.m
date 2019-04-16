function dy=erprop(f,a,da,b,db)
N=nargin;

if N==3
    x=pder(f,a,da);
    t1=(x.*da).^2;    
    dy=t1.^0.5;
elseif N==5
    
    [x,y]=pder(f,a,da,b,db);
    t1=(x.*da).^2;
    t2=(y.*db).^2;
    
    dy=(t1+t2).^0.5;
end

