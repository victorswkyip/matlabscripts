function [new_omegas_set,new_fields_set]=get_omegas(omegas_set,fields_set,delta)
Z=1./fields_set;
Z=Z*max(fields_set);
norm_omegas=max(abs(omegas_set));
omegas_set_n=omegas_set/norm_omegas;
if length(omegas_set)==1 && length(fields_set)==1
    new_omegas_set=[omegas_set,omegas_set*(1-delta)];
    new_fields_set=[fields_set,0];
    
elseif length(omegas_set)==2 && length(fields_set)==2
    new_omegas_set=[omegas_set,omegas_set(1)*(1+delta)];
    new_fields_set=[fields_set,0];
    
elseif length(omegas_set)==3 && length(fields_set)==3
    A(1,:)=omegas_set_n.*Z;
    A(2,:)=Z;
    A(3,:)=1;
    B=omegas_set_n;
    X=B/A;
    new_omega=norm_omegas*X(3);
    [~,index]=sort(abs(fields_set));
    new_omegas_set=[omegas_set(index(3:-1:2)),new_omega];
    new_fields_set=[fields_set(index(3:-1:2)),0];
else
    fprintf('omega_generation : wrong dimensions for the sets (omega and/or field)');
    return
end

end