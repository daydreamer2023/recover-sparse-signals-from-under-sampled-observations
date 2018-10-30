function [xOrthogonalMatchingPursuit] = orthogonal_matching_pursuit(sparseCardinality, a, y, normalizedErrorBound)
% initialization
xOrthogonalMatchingPursuit = zeros(size(a, 2), 1);
sparseSupport = [];
iBasis = 0;
nBasis = sparseCardinality;
yResidue = y;
doTerminate = 0;
normalizedError = 1;
while (iBasis < nBasis) && (~ doTerminate)
    iBasis = iBasis + 1;
    normalizedErrorLast = normalizedError;
    % proportional to vector residue of x to be decomposite sparsely;
    % scale should be 1 / det(a' * a), ignored for simplicity
    residueFunction = a' * yResidue;
    [~, sparseSupportCurrent] = max(abs(residueFunction));
    sparseSupport = union(sparseSupport, sparseSupportCurrent);
    aSparseMarch = a(:, sparseSupport);
    xSparseMarch = aSparseMarch \ y;
    yResidue = y - aSparseMarch * xSparseMarch;
    xOrthogonalMatchingPursuit(sparseSupport) = xSparseMarch;
    % terminate conditions
    normalizedError = norm(yResidue) / norm(y);
    isTolerable = normalizedError <= normalizedErrorBound;
    isDivergent = normalizedError >= normalizedErrorLast;
    doTerminate = (isDivergent || isTolerable);
end
end
