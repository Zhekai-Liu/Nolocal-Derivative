% x' = cos(x);
% we want use kernel = 1/ (distance)^0.5;
% integral region is ( -(0.75)^(2/3),(0.75)^(2/3) );

x = linspace(0,2*pi,100);
b = zeros(1,96);
u_100 = zeros(1,100);
u_96 = zeros(1,96);
A = zeros(96,100);
for i = 1:96
    b(i) = cos(x(i+2));
end


u_100(1) = sin(x(1));
u_100(2) = sin(x(2));
u_100(99) = sin(x(99));
u_100(100) = sin(x(100));

% u_1, u_2, u_99, u_100 are known
for i = 3:98
    
    if (x(i)-x(i-2)) > 0.75^(2/3)% it's doesn't matter. N is really large.
        A(i-2, i-2) = 0;
        A(i-2, i+2) = 0;
    else
        A(i-2, i-2) = -1 / (x(i)-x(i-2))^(0.4);
        A(i-2, i+2) =  1 / (x(i)-x(i-2))^(0.4);
    end

    if (x(i)-x(i-1)) > 0.75^(2/3)
        A(i-2, i-1) = 0;
        A(i-2, i+1) = 0;
    else
        A(i-2, i-1) = -1 / (x(i)-x(i-1))^(0.4);
        A(i-2, i+1) =  1 / (x(i)-x(i-1))^(0.4);
    end

end

b(1) = b(1) - A(1,1)*u_100(1) - A(1,2)*u_100(2);
A(1,1) = 0;
A(1,2) = 0;
b(2) = b(2) - A(2,2)*u_100(2);
A(2,2) = 0;

b(96) = b(96) - A(96,100)*u_100(100) - A(96,99)*u_100(99);
A(96,100) = 0;
A(96,99) = 0;
b(95) = b(95) - A(95,99)*u_100(99);
A(95,99) = 0;
colsToRemove = [1 2 99 100];      % 要去掉的列的索引数组

A(:, colsToRemove) = [];  % 去掉指定的列


%x = b
solve_96 = linsolve(A, b.');       % 求解 Ax = b

solve_100 = zeros(1,100);

solve_100(1) = u_100(1);
solve_100(2) = u_100(2);
solve_100(99) = u_100(99);
solve_100(100) = u_100(100);
for i = 1:96
    solve_100(i+2) = solve_96(i);
end

figure;
plot(x,solve_100);
