function [xSubspacePursuit] = subspace_pursuit(sparseCardinality, a, y)
% initialization
xSubspacePursuit = zeros(size(a, 2),1);
b = zeros(size(a, 2),1);
% iBasis = 0;
% nBasis = sparseCardinality;
normalizedErrorBound = 1e-6;
doTerminate = 0;
normalizedErrorLast = 1;

[sparseSupport] = hard_threshold(a' * y, sparseCardinality);
aSparseMarch = a(:, sparseSupport);
xSparseMarch = aSparseMarch \ y;
yResidue = y - aSparseMarch * xSparseMarch;

while (~ doTerminate)
%     iBasis = iBasis + 1;
    [sparseSupportResidue] = hard_threshold(a' * yResidue, sparseCardinality);
    sparseSupportExpand = union(sparseSupport, sparseSupportResidue);
    aSparseExpand = a(:, sparseSupportExpand);
    bSparseExpand = aSparseExpand \ y;
    b(sparseSupportExpand) = bSparseExpand;
    % bug
    sparseSupport = hard_threshold(b, sparseCardinality);
    aSparseSub = a(:, sparseSupport);
    xSparseSub = aSparseSub \ y;
    yResidue = y - aSparseSub * xSparseSub;
    xSubspacePursuit(sparseSupport) = xSparseSub;
    % terminate conditions
    normalizedError = norm(yResidue) / norm(y);
    isTolerable = normalizedError <= normalizedErrorBound;
    isDivergent = normalizedError > normalizedErrorLast;
    doTerminate = (isDivergent || isTolerable);
    
%     residueFunction = a' * yResidue;
%     [~, residueSupportCurrent] = max(abs(residueFunction));
%     sparseSupport = union(sparseSupport, residueSupportCurrent);
%     aSparseMarch = a(:, sparseSupport);
%     xSparseMarch = aSparseMarch \ y;
%     yResidue = y - aSparseMarch * xSparseMarch;
%     xOrthogonalMatchingPursuit(sparseSupport) = xSparseMarch;
end
end

