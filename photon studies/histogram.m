%Victor Yip
function histogram

ave=80;
stdv=7.5;

for i=1:1:5000
    grades=gradegen(ave,stdv);
    gp=gpcalc(grades);
    GPA(1,i)=mean(gp);
end

X=50:1:100;
figure(1)
hist(grades, X);
title('Histogram of Grades for a Student with an 80% average and Std. Dev. of 7.5')
xlabel('Grade[%]')
ylabel('Number of Occurencies of Grade')


Y=1.5:0.1:4.3;
figure(2)
hist(gp,Y)
title('Histogram of GPA for a Student with an 80% average and Std. Dev. of 7.5')
xlabel('GPA')
ylabel('Number of Occurencies of Grade')
figure(3)
Z=3.3:0.02:4.0;
hist(GPA,Z)




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

function gp=gpcalc(grades)
for i=1:1:length(grades)
    if grades(1,i)<50
        gp(1,i)=0;
    elseif grades(1,i)<=53
        gp(1,i)=0.7;
    elseif grades(1,i)<=57
        gp(1,i)=1.0;
    elseif grades(1,i)<=60
        gp(1,i)=1.3;
    elseif grades(1,i)<=63
        gp(1,i)=1.7;
    elseif grades(1,i)<=67
        gp(1,i)=2.0;
    elseif grades(1,i)<=70
        gp(1,i)=2.3;
    elseif grades(1,i)<=73
        gp(1,i)=2.7;
    elseif grades(1,i)<=77
        gp(1,i)=3.0;
    elseif grades(1,i)<=80
        gp(1,i)=3.3;
    elseif grades(1,i)<=85
        gp(1,i)=3.7;
    elseif grades(1,i)<90
        gp(1,i)=4.0;
    else
        gp(1,i)=4.3;
    end
end
end