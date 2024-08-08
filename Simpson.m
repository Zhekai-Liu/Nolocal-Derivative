%For sin(x) from 0 \to pi
%This one is more precise
N = 10
x = linspace(0,pi,N)
sum = 0
for i = 1:N-1
    sum = sum + ( sin(x(i+1)) + 4*sin( (x(i+1)+x(i))/2 )  + sin(x(i)) )*(x(i+1) - x(i))/6
end