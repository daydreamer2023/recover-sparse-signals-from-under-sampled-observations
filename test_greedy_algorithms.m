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
errorExact = norm(y - a * xExact);
errorLeastSquare = norm(y - a * xLeastSquare);
errorBasic = norm(y - a * xBasic);
errorOmp = norm(y - a * xOmp);
