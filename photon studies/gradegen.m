function histogram
%Victor Yip
ave=80;
stdv=7.5;
grades=gradegen(ave,stdv);
X=50:1:100
figure(1)
hist(grades, X);
end

function grades=gradegen(ave,stdv)
N=48;
grades=randn(1,N)*stdv+ave;
while(mean(grades)>(ave+0.2)) || (mean(grades)<(ave-0.2))
    grades=randn(1,N)*stdv+ave;
end
for i=1:1:N
    if (grades(1,i)<0)
        grades(1,i)=0;
    elseif(grades(1,i)>100)
        grades(1,i)=100;
    end
end
end
