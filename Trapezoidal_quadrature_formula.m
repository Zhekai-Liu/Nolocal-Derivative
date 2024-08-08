%for sin(x) from 0 \to pi
N = 10
x = linspace(0,pi,N)
sum = 0
for i = 1:N-1
    sum = sum + ( sin(x(i+1))+sin(x(i)) )*(x(i+1)-x(i))/2
end
