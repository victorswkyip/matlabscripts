function area=evalarea

D=importdata('Hyst 2012 iron.CSV'); vx=D(:,2); vy=D(:,3);
plot(vx,vy);
for i=1:1:length(vx)-1
    h(i)=vx(i+1)-vx(i)
    if h(i)<0
        areatop(i)=(h(i)./2).*(vy(i+1)+vy(i))
    elseif h(i)>0
        areabot(i)=(h(i)./2).*(vy(i+1)+vy(i))
    end
end
atopcurve=sumelements(-areatop)
abotcurve=sumelements(areabot)

area=atopcurve-abotcurve
end