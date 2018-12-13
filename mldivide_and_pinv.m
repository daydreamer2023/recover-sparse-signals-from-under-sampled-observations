clear; close all;
%% Initial value
% m rows -> equations, n columns -> vars
m = 128; n = 256; 
A = normc(randn(m, n));
x = randn(n, 1);
y = A * x;
%% exact solution, least-squares solution, and basic solution
xExact = x;
xBasic = pinv(A) * y;
xLeastSquare = A \ y;
% corresponding errors
errorMeanExact = mean(A * xExact - y);
errorMeanBasic = mean(A * xBasic - y);
errorMeanLeastSquare = mean(A * xLeastSquare - y);
%% Ground truth solution vs Underdetermined solutions
xExactIndex = find (xExact ~= 0);
xBasicIndex = find(xBasic ~= 0);
xLeastSquareIndex = find(xLeastSquare ~= 0);
figure;
% basic solution
basicFig = subplot(2, 1, 1);
plot(xExactIndex, xExact, 'black');
hold on;
xBasicPlot = plot(xBasic, 'red');
xlim([0 n]);
title('Basic Solution of Underdetermined System by Pseudo Inverse');
xlabel('x basis index');
ylabel('x entries value');
legend('Exact solution', 'Basic solution', 'Location', 'northeast');
% least-squares solution
leastSquareFig = subplot(2, 1, 2);
plot(xExactIndex, xExact, 'black');
hold on;
xLeastSquarePlot = plot(xLeastSquare, 'magenta');
xlim([0 n]);
title('Least-squares Solution of Underdetermined System by Mldivide');
xlabel('x basis index');
ylabel('x entries value');
legend('Exact solution', 'Least-squares solution', 'Location', 'northeast');
