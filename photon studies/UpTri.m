function AB=UpTri(AB)
Nrow=length(AB(:))/length(AB);
Ncol=length(AB);

for i=1:1:Nrow-1
    subAB=AB(i:Nrow,i:Ncol)
    AB(i:Nrow,i:Ncol)=elim(subAB)
end

if AB(Nrow,Ncol-1)==0
    error('0 in the last diagonal')
end

end