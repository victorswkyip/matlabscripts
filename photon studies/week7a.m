function [t]=values(T,N)
clc
t=zeros(1,N)

interval = T/N

for i=2:1:N
    t(i)=t(i-1)+interval
end

end