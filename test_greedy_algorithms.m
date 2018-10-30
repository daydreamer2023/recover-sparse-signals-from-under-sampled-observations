clear; close all;
%% Initial value
% m rows -> equations, n columns -> vars
m = 128; n = 256; sparseCardinality = 12;
a = normc(randn(m, n));
x = zeros(n, 1);
normalizedErrorBound = 1e-6;
% sparse support, or index. 'false' ensures no repeat
sparseSupport = randsample(n, sparseCardinality, 'false');
% x is the s-sparse vector
randnTemp = randn(sparseCardinality, 1);
x(sparseSupport) = randnTemp;
y = a * x;
%% Generated solutions and their normalized error
xExact = x;
xLeastSquare = a \ y;
xBasic = pinv(a) * y;
xOmp = orthogonal_matching_pursuit(sparseCardinality, a, y, normalizedErrorBound);
xSp = subspace_pursuit(sparseCardinality, a, y, normalizedErrorBound);
xIht = iterative_hardthresholding(sparseCardinality, a, y, normalizedErrorBound);
% errors
errorExact = norm(y - a * xExact) / norm(y);
errorLeastSquare = norm(y - a * xLeastSquare) / norm(y);
errorBasic = norm(y - a * xBasic) / norm(y);
errorOmp = norm(y - a * xOmp) / norm(y);
errorSp = norm(y - a * xSp) / norm(y);
errorIht = norm(y - a * xIht) / norm(y);
flag = 1;
% %% Plot
% stem(xOmp(xOmp~=0));
%% Ground truth solution vs greedy solutions
xExactIndex = find (xExact ~= 0);
xOmpIndex = find(xOmp ~= 0);
xSpIndex = find(xSp ~= 0);
xIhtIndex = find(xIht ~= 0);
figure;
% orthogonal matching pursuit
ompFig = subplot(3, 1, 1);
scatter(xExactIndex, xExact(xExact ~= 0), 'x', 'black');
hold on;
xOmpScatter = scatter(xOmpIndex, xOmp(xOmp ~= 0), 'o', 'red');
xlim([0 n]);
title('Sparse solution (x): orthogonal matching pursuit');
xlabel('x basis index');
ylabel('x entries value');
legend('Exact solution', 'OMP solution', 'Location', 'bestoutside');
% subspace pursuit
spFig = subplot(3, 1, 2);
scatter(xExactIndex, xExact(xExact ~= 0), 'x', 'black');
hold on;
xSpScatter = scatter(xSpIndex, xSp(xSp ~= 0), 'o', 'magenta');
xlim([0 n]);
title('Sparse solution (x): subspace pursuit');
xlabel('x basis index');
ylabel('x entries value');
legend('Exact solution', 'SP solution', 'Location', 'bestoutside');
% iterative hardthresholding
ihtFig = subplot(3, 1, 3);
scatter(xExactIndex, xExact(xExact ~= 0), 'x', 'black');
hold on;
xIhtScatter = scatter(xIhtIndex, xIht(xIht ~= 0), 'o', 'blue');
xlim([0 n]);
title('Sparse solution (x): iterative hardthresholding');
xlabel('x basis index');
ylabel('x entries value');
legend('Exact solution', 'IHT solution', 'Location', 'bestoutside');
