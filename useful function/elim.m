function AB=elim(AB)
Nrow=length(AB(:))/length(AB);
for i=2:1:Nrow
    AB(i,:)=AB(i,:)-((AB(i,1)/AB(1,1))*AB(1,:));
end
end
