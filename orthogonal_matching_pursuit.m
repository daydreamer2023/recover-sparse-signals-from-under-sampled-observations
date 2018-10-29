function [xOrthogonalMatchingPursuit] = orthogonal_matching_pursuit(sparseCardinality, a, y)
% initialization
xOrthogonalMatchingPursuit = zeros(size(a, 2),1);
sparseSupport = [];
iBasis = 0;
nBasis = sparseCardinality;
% aSparse = zeros(size(a, 1), sparseCardinality);
normalizedErrorBound = 1e-6;
doTerminate = 0;
while (iBasis < nBasis) && (~ doTerminate)
    iBasis = iBasis + 1;
    % initialize or update error
    if (iBasis == 1)
        yResidue = y;
        normalizedErrorLast = 1;
    else
        normalizedErrorLast = normalizedError;
    end
    % proportional to vector residue of x to be decomposite sparsely;
    % scale should be 1 / det(a' * a), ignored for simplicity
    residueFunction = a' * yResidue;
    [~, residueSupportCurrent] = max(abs(residueFunction));
    sparseSupport = union(sparseSupport, residueSupportCurrent);
    aSparseMarch = a(:, sparseSupport);
    xSparseMarch = aSparseMarch \ y;
    yResidue = y - aSparseMarch * xSparseMarch;
    xOrthogonalMatchingPursuit(sparseSupport) = xSparseMarch;
    % terminate conditions
    normalizedError = norm(yResidue) / norm(y);
    isTolerable = normalizedError <= normalizedErrorBound;
    isDivergent = normalizedError > normalizedErrorLast;
    doTerminate = (isDivergent || isTolerable);
end
flag = 1;
