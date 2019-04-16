function AB=UpTri(AB)
Nrow=length(AB(:))/length(AB);
Ncol=length(AB);

for i=1:1:Nrow-1
    subAB=AB(i:Nrow,i:Ncol);
    AB(i:Nrow,i:Ncol)=elim(subAB);
end
end