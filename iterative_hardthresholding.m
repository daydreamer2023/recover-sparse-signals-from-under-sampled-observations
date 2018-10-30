function [xIterativeHardthresholding] = iterative_hardthresholding(sparseCardinality, a, y)
% initialization
xIterativeHardthresholding = zeros(size(a, 2), 1);

normalizedErrorBound = 1e-6;
doTerminate = 0;
normalizedError = 1;

while (~ doTerminate)
    normalizedErrorLast = normalizedError;
    sparseSupport = hard_threshold(xIterativeHardthresholding + a' * (y - a * xIterativeHardthresholding), sparseCardinality);
    aSparseIter = a(:, sparseSupport);
    xSparseIter = aSparseIter \ y;
    yResidue = y - aSparseIter * xSparseIter;
    xIterativeHardthresholding(sparseSupport) = xSparseIter;
    % terminate conditions
    normalizedError = norm(yResidue) / norm(y);
    isTolerable = normalizedError <= normalizedErrorBound;
    isDivergent = normalizedError >= normalizedErrorLast;
    doTerminate = (isDivergent || isTolerable);
end
end

