% Function: 
%   - solve the equations with subspace pursuit algorithm
%
% InputArg(s):
%   - sparseCardinality: number of non-zero values in sparse solution x
%   - a: observation matrix
%   - y: observation vector with insufficient samples
%   - normalizedErrorBound: the maximum tolerable error
%
% OutputArg(s):
%   - xSubspacePursuit: sparse solution by SP algorithm
%
% Comments:
%   - consider subspace with dimension s out of 2s every time - efficient
%   - reconstruct solution out of that in 2s subspace - accurate
%
% Author & Date: Yang (i@snowztail.com) - 02 Nov 18
function [xSubspacePursuit] = subspace_pursuit(sparseCardinality, a, y, normalizedErrorBound)
[sparseSupport] = hard_threshold(a' * y, sparseCardinality);
aSparseMarch = a(:, sparseSupport);
xSparseMarch = aSparseMarch \ y;
yResidue = y - aSparseMarch * xSparseMarch;
doTerminate = 0;
normalizedError = 1;
while (~ doTerminate)
    normalizedErrorLast = normalizedError;
    [sparseSupportResidue] = hard_threshold(a' * yResidue, sparseCardinality);
    % expand the investigated subspace
    sparseSupportExpand = [sparseSupport; sparseSupportResidue];
    aSparseExpand = a(:, sparseSupportExpand);
    bSparseExpand = aSparseExpand \ y;
    b = zeros(size(sparseSupportExpand));
    % expanded solution
    b(sparseSupportExpand) = bSparseExpand;
    sparseSupport = hard_threshold(b, sparseCardinality);
    aSparseSub = a(:, sparseSupport);
    xSparseSub = aSparseSub \ y;
    xSubspacePursuit = zeros(size(a, 2), 1);
    xSubspacePursuit(sparseSupport) = xSparseSub;
    yResidue = y - a * xSubspacePursuit;
    % terminate conditions
    normalizedError = norm(yResidue) / norm(y);
    isTolerable = normalizedError <= normalizedErrorBound;
    isDivergent = normalizedError >= normalizedErrorLast;
    doTerminate = (isDivergent || isTolerable);
end
end

