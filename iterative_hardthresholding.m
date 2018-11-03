% Function: 
%   - solve the equations with iterative hardthresholding algorithm
%
% InputArg(s):
%   - sparseCardinality: number of non-zero values in sparse solution x
%   - a: observation matrix
%   - y: observation vector with insufficient samples
%   - normalizedErrorBound: the maximum tolerable error
%
% OutputArg(s):
%   - xIterativeHardthresholding: sparse solution by IHT algorithm
%
% Comments:
%   - simply iterate to approach the solution and truncate the result -
%   inefficient
%
% Author & Date: Yang (i@snowztail.com) - 02 Nov 18
function [xIterativeHardthresholding] = iterative_hardthresholding(sparseCardinality, a, y, normalizedErrorBound)
xIterativeHardthresholding = zeros(size(a, 2), 1);
yResidue = y;
doTerminate = 0;
normalizedError = 1;
while (~ doTerminate)
    normalizedErrorLast = normalizedError;
    xPreSparse = xIterativeHardthresholding + a' * yResidue;
    sparseSupport = hard_threshold(xPreSparse, sparseCardinality);
    xIterativeHardthresholding = zeros(size(a, 2), 1);
    xIterativeHardthresholding(sparseSupport) = xPreSparse(sparseSupport);
    yResidue = y - a * xIterativeHardthresholding;
    % terminate conditions
    normalizedError = norm(yResidue) / norm(y);
    isTolerable = normalizedError <= normalizedErrorBound;
    isDivergent = normalizedError >= normalizedErrorLast;
    doTerminate = (isDivergent || isTolerable);
end
end

