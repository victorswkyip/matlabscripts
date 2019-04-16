function task2
f=@(x,y) (10.^-((x.^2)+y.^2)).*cos(pi.*x-pi./3); % Make up an interesting function
col=0; % initialize column loop counter
for x=-1.0:0.1:1 % loop over all the columns
    col=col+1;
    row=0; % initialize row loop counter
    for y=-1:0.1:1 % loop over all the rows
        row=row+1;
        XX(row,col)=x; % array storing the x-coord at each grid point
        YY(row,col)=y; % array storing the Y-coord at each grid point
        ZZ(row,col)=f(x,y); % array storing the value of the function
    end
end


h=0.001
[a,b]=pder(f,XX,h,YY,h)

figure(1);
quiver(a,b)

axis equal;

end
