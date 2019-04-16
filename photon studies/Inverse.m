function Ainv=Inverse(AB)
[Nr,Nc]= size(AB)
I=eye(Nr);

for i=1:1:Nc
    Aug=[AB,I(:,i)];
    Ainv(:,i)= BackSub(Aug);
end
tol=0;

D=AB*Ainv-I;

for j=1:1:Nr
    for i=1:1:Nc
        tol=tol+abs(D(j,i));
    end
end

if tol>3e-14    
    disp('Your matrix is ill conditioned')
end

end