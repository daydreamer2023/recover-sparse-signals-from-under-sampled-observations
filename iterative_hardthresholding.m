function [xIterativeHardthresholding] = iterative_hardthresholding(sparseCardinality, a, y, normalizedErrorBound)
% initialization
xIterativeHardthresholding = zeros(size(a, 2), 1);
doTerminate = 0;
normalizedError = 1;
yResidue = y;
while (~ doTerminate)
    normalizedErrorLast = normalizedError;
%     sparseSupport = hard_threshold(xIterativeHardthresholding + a' * (y - a * xIterativeHardthresholding), sparseCardinality);
%     aSparseIter = a(:, sparseSupport);
%     xSparseIter = aSparseIter \ y;
%     yResidue = y - aSparseIter * xSparseIter;
%     xIterativeHardthresholding(sparseSupport) = xSparseIter;
    

    xPreSparse = xIterativeHardthresholding + a' * yResidue;
    sparseSupport = hard_threshold(xIterativeHardthresholding + a' * yResidue, sparseCardinality);
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

