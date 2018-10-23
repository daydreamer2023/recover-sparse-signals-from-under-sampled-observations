function [xOrthogonalMatchingPursuit] = orthogonal_matching_pursuit(sparseCardinality, a, y)
% initialization
xOrthogonalMatchingPursuit = zeros(size(a, 2),1);
yResidue = y;
sparseSupportIndex = [];
iBasis = 0;
nBasis = sparseCardinality;
% aSparse = zeros(size(a));
% TODO
doTerminate = 0;

while (iBasis < nBasis) && (~ doTerminate)
    yResidueLast = yResidue;
    iBasis = iBasis + 1;
    % proportional to vector residue of x to be decomposite sparsely
    % scale should be 1 / det(a' * a), ignored for simplicity
    residueFunction = a' * yResidue;
%     xHardThreshold = wthresh(x, 'h', max(x) - 1e-10);
    [~, xResidueSupport] = max(abs(residueFunction));
    sparseSupportIndex = union(sparseSupportIndex, xResidueSupport);
    aSparse(:, iBasis) = a(:, xResidueSupport);
    xSparse = aSparse \ y;
    xOrthogonalMatchingPursuit(xResidueSupport) = xSparse(iBasis);
    yResidue = y - a * xOrthogonalMatchingPursuit;
    % terminate conditions
    % TODO
    isDivergent = mean(yResidue) >= mean(yResidueLast);
    isTolerable = 0;
    doTerminate = (isDivergent || isTolerable);
end
