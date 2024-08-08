% For sin(x)
% Now we already have the methods to caculate integral.
% So the only thing we need to do is find a appropriate kernel function.
%% for example； Kernel_function = -1/n<x<0 ?? 0<x<1/n: -n^2 or n^2; 

n = 2; % n trends to infinity, where 'n' is in kernel_function -1/n<x<0 ?? 0<x<1/n: -n^2 or n^2;

n0 = 20; % I want to draw the derivative figure from (0,2*pi);
x0 = linspace(0,2*pi,n0); % So I take these points, there are n0 points in x0;

D_step = zeros(1,n0); % Use this vector to record every points in x0;
D_h = zeros(1,n0);
%% integral
N = 10;
h_postive1 = linspace(0,1/n,N); % Please refer to Trapezoidal code;
h_postive2 = linspace(0,(0.75)^(2/3),N);
h_negetive1 = linspace(-1/n,0,N);
h_negetive2 = linspace(-(0.75)^(2/3),0,N);

for k = 1:n0  % Calculate integral for every poins in x0, and record them in Df(K);
 % Now let us calculate integral for each x0(k)；
sum_step = 0;
sum_h = 0;
for i = 1:N-1
    sum_step = sum_step + ( f_positive1(x0(k),h_postive1(i+1),n) + f_positive1(x0(k),h_postive1(i),n) )*(h_postive1(i+1)-h_postive1(i))/2;
end

for i = 2:N-1
        sum_h = sum_h + ( f_positive2(x0(k),h_postive2(i+1),n) + f_positive2(x0(k),h_postive2(i),n) )*(h_postive2(i+1)-h_postive2(i))/2;
end

for i = 1:N-1
    sum_step = sum_step + ( f_negetive1(x0(k),h_negetive1(i+1),n)+f_negetive1(x0(k),h_negetive1(i),n) )*(h_negetive1(i+1)-h_negetive1(i))/2;
end

for i = 1:N-2
    sum_h = sum_h + ( f_negetive2(x0(k),h_negetive2(i+1),n)+f_negetive2(x0(k),h_negetive2(i),n) )*(h_negetive2(i+1)-h_negetive2(i))/2;
end

D_step(k) = sum_step;
D_h(k) = sum_h;
% I'm now splitting the kernel function into two parts(positive and negative)
% and doing integral respectively.

end

figure
plot(x0,D_step,'r','DisplayName','1/h^2\chi_{[0,h]} - 1/h^2\chi_{[-h,0]}')
hold on
plot(x0,D_h,'b','DisplayName','1/|z|^{0.4}')
hold on 
x = linspace(0,2*pi,50);
plot(x,cos(x),'k','DisplayName','cos(x)')
hold off

legend('show');

% 设置 x 轴和 y 轴名称
xlabel('x');
ylabel('y');

% 添加标题
title('Compare with different Kernel function');

function y = f_positive1(x0,h,n)
    y = (f_orignal(x0+h) - f_orignal(x0))*n^2;
end
function y = f_positive2(x0,h,n)
    y = (f_orignal(x0+h) - f_orignal(x0))*(1/(abs(h)^(0.4)));
end

function y = f_negetive1(x0,h,n)
    y = -(f_orignal(x0+h) - f_orignal(x0))*n^2;
end
function y = f_negetive2(x0,h,n)
    y = -(f_orignal(x0+h) - f_orignal(x0))*(1/(abs(h)^0.4));
end

function y = f_orignal(x0)
    y = sin(x0);
end

