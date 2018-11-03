% Function: 
%   - solve the equations with orthogonal matching pursuit algorithm
%
% InputArg(s):
%   - sparseCardinality: number of non-zero values in sparse solution x
%   - a: observation matrix
%   - y: observation vector with insufficient samples
%   - normalizedErrorBound: the maximum tolerable error
%
% OutputArg(s):
%   - xOrthogonalMatchingPursuit: sparse solution by OMP algorithm
%
% Comments:
%   - only consider one more dimension for subspace at a time: inefficient
%   - all component of solution updated for updated subspace: accurate
%
% Author & Date: Yang (i@snowztail.com) - 02 Nov 18
function [xOrthogonalMatchingPursuit] = orthogonal_matching_pursuit(sparseCardinality, a, y, normalizedErrorBound)
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
    % scale should be 1 / det(a' * a), 1 in this case
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
