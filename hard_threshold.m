function [sparseSupport] = hard_threshold(object, nElements)
% [hardThreshold, sparseSupport] = max(abs(residueFunction));
% hardThreshold = hardThreshold * sign(residueFunction(sparseSupport));
% hardVector = residueFunction;
% hardVector(hardVector < hardThreshold) = 0;

[~, descendIndex] = sort(abs(object),'descend');
sparseSupport = descendIndex(1: nElements);
% 
% aSparseMarch = a(:, sparseSupport);
% xSparseMarch = aSparseMarch \ y;
% yResidue = y - aSparseMarch * xSparseMarch;
end

