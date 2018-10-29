function [xOrthogonalMatchingPursuit] = orthogonal_matching_pursuit(sparseCardinality, a, y)
% initialization
xOrthogonalMatchingPursuit = zeros(size(a, 2),1);
sparseSupportIndex = [];
iBasis = 0;
nBasis = sparseCardinality;
aSparse = zeros(size(a, 1), sparseCardinality);
normalizedErrorBound = 1e-6;
% TODO
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
    [~, xResidueSupport] = max(abs(residueFunction));
    sparseSupportIndex = union(sparseSupportIndex, xResidueSupport);
%     aSparse(:, iBasis) = a(:, xResidueSupport);
%     a(:, xResidueSupport) = 0;
%     aSparseSub = aSparse(:, 1: iBasis);
%     xSparseSub = (aSparseSub' * aSparseSub) \ aSparseSub' * y;
    aSparseSub = a(:,sparseSupportIndex);
    xSparseSub = aSparseSub \ y;
    yResidue = y - aSparseSub * xSparseSub;
    xOrthogonalMatchingPursuit(sparseSupportIndex) = xSparseSub;
    % terminate conditions
    normalizedError = norm(yResidue) / norm(y);
    isTolerable = normalizedError <= normalizedErrorBound;
    isDivergent = normalizedError > normalizedErrorLast;
    doTerminate = (isDivergent || isTolerable);
end
flag = 1;
