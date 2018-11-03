% Function: 
%   - obtain hard thresholding index (i.e. index of several largest values
%   of the input vector)
%
% InputArg(s):
%   - object: input vector
%   - nElements: number of largest values
%
% OutputArg(s):
%   - sparseSupport: index of those largest values
%
% Comments:
%   - only index is returned
%
% Author & Date: Yang (i@snowztail.com) - 02 Nov 18
function [sparseSupport] = hard_threshold(object, nElements)
% descend ensures larger first
[~, descendIndex] = sort(abs(object),'descend');
sparseSupport = descendIndex(1: nElements);
end

