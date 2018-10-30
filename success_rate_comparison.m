clear; close all;
warning('off', 'MATLAB:rankDeficientMatrix');
%% Initial value
% m rows -> equations, n columns -> vars
m = 128; n = 256;
nTests = 500;
normalizedErrorBound = 1e-6;
sparseCardinalitySet = 3: 3: 63;
nCardinalities = length(sparseCardinalitySet);
ompSuccessRate = zeros(1, nCardinalities);
spSuccessRate = zeros(1, nCardinalities);
ihtSuccessRate = zeros(1, nCardinalities);
%% Success rate
for iCardinality = 1: nCardinalities
    sparseCardinality = sparseCardinalitySet(iCardinality);
    ompCounter = 0; spCounter = 0; ihtCounter = 0;
    for iTest = 1: nTests
        [a, x, y] = linear_equation_generation(m, n, sparseCardinality);
        xOmp = orthogonal_matching_pursuit(sparseCardinality, a, y, normalizedErrorBound);
        xSp = subspace_pursuit(sparseCardinality, a, y, normalizedErrorBound);
        xIht = iterative_hardthresholding(sparseCardinality, a, y, normalizedErrorBound);
        errorOmp = norm(y - a * xOmp) / norm(y);
        errorSp = norm(y - a * xSp) / norm(y);
        errorIht = norm(y - a * xIht) / norm(y);
        ompCounter = ompCounter + (errorOmp <= normalizedErrorBound);
        spCounter = spCounter + (errorSp <= normalizedErrorBound);
        ihtCounter = ihtCounter + (errorIht <= normalizedErrorBound);
    end
    ompSuccessRate(iCardinality) = ompCounter / nTests;
    spSuccessRate(iCardinality) = spCounter / nTests;
    ihtSuccessRate(iCardinality) = ihtCounter / nTests;
end
figure;
ompCurve = plot(sparseCardinalitySet, ompSuccessRate);
hold on;
spCurve = plot(sparseCardinalitySet, spSuccessRate);
hold on;
ihtCurve = plot(sparseCardinalitySet, ihtSuccessRate);
title('Sparse solution (x): success rate comparison');
xlabel('Sparse cardinality');
ylabel('Success rate of recovering the ground truth signal');
legend('OMP solution', 'SP solution', 'IHT solution');
flag = 1;