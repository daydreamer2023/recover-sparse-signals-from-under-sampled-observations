clear; close all;
%% Initial value
% m rows -> equations, n columns -> vars
m = 128; n = 256; 
A = normc(randn(m, n));
x = randn(n, 1);
y = A * x;
%% exact solution, least-squares solution, and basic solution
xExact = x;
xLeastSquare = A \ y;
xBasic = pinv(A) * y;
% corresponding errors
errorMeanExact = mean(A * xExact - y);
errorMeanLeastSquare = mean(A * xLeastSquare - y);
errorMeanBasic = mean(A * xBasic -y);
