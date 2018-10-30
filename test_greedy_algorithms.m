clear; close all;
%% Initial value
% m rows -> equations, n columns -> vars, s is the sparsity
m = 128; n = 256; sparseCardinality = 12;
a = normc(randn(m, n));
x = zeros(n, 1);
% sparse support, or index. 'false' ensures no repeat
sparseSupport = sort(randsample(n, sparseCardinality, 'false'));
% x is the s-sparse vector
randnTemp = randn(n, 1);
x(sparseSupport) = randnTemp(sparseSupport);
y = a * x;
%% exact solution, least-squares solution, and basic solution
xExact = x;
xLeastSquare = a \ y;
xBasic = pinv(a) * y;
xOmp = orthogonal_matching_pursuit(sparseCardinality, a, y);
xSp = subspace_pursuit(sparseCardinality, a, y);
xIht = iterative_hardthresholding(sparseCardinality, a, y);
% errors
errorExact = norm(y - a * xExact) / norm(y);
errorLeastSquare = norm(y - a * xLeastSquare) / norm(y);
errorBasic = norm(y - a * xBasic) / norm(y);
errorOmp = norm(y - a * xOmp) / norm(y);
errorSp = norm(y - a * xSp) / norm(y);
errorIht = norm(y - a * xIht);
flag = 1;
