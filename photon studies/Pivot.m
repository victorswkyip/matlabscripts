function AB=Pivot(AB)
[Nr,Nc]=size(AB); 

[MaxValue,RowIndex]=max(abs(AB));

Temp=AB(1,:);
AB(1,:)=AB(RowIndex(1),:);
AB(RowIndex(1),:)=Temp;


end