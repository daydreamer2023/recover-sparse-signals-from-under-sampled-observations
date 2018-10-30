function [a, x, y] = linear_equation_generation(m, n, sparseCardinality)
a = normc(randn(m, n));
x = zeros(n, 1);
% sparse support, or index. 'false' ensures no repeat
sparseSupport = randsample(n, sparseCardinality, 'false');
% x is the s-sparse vector
randnTemp = randn(sparseCardinality, 1);
x(sparseSupport) = randnTemp;
y = a * x;
end

