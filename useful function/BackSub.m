function X=BackSub(AB)
clc;
Nrow=length(AB(:))/length(AB);
Ncol=length(AB);

T=UpTri(AB)
A=T(:,1:Ncol-1)
B=T(:,Ncol)
X=zeros(Nrow,1)
for n=Nrow:-1:1
    X(n)=(B(n)-(A(n,:))*X)/A(n,n)
end
% X4=B(Nrow2)/A(Nrow2,Ncol2)
%
% X3=(B(Nrow2-1)-X4*(A(Nrow2-1,Ncol2)))/A(Nrow2-1,Ncol2-1)
%
% X2=(B(Nrow2-2)-X4*(A(Nrow2-2,Ncol2))-X3*(A(Nrow2-2,Ncol2-1)))/A(Nrow2-2,Ncol2-2)
%
% X1=(B(Nrow2-3)-X4*(A(Nrow2-3,Ncol2))-X3*(A(Nrow2-3,Ncol2-1))-X2*(A(Nrow2-3,Ncol2-2)))/A(Nrow2-3,Ncol2-3)
%
% X=[X1;X2;X3;X4]
D=AB(:,1:Ncol-1)
test=D*X
end
