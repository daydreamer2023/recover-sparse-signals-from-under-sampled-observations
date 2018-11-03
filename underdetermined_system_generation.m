% Function: 
%   - generate an underdetermined system in terms of linear equations
%
% InputArg(s):
%   - m: number of restrictions
%   - n: number of unknowns
%   - sparseCardinality: number of non-zero values in sparse solution x
%
% OutputArg(s):
%   - a: observation matrix
%   - x: sparse signal with given cardinality
%   - y: observation vector with insufficient samples
%
% Comments:
%   - this model can be used to simulate observing (sampling) signals in a
%   certain domain (i.e. after a certain transformation as FT or WT) that
%   appears sparse
%   - as long as the target is sparse, the signal can be recovered coarsely
%   or accurately by randomly sampling with rate far less than Nyquist rate
%   - in this simulation we assume the original signal is already sparse
%   - if not, another transformation matrix can be introduced to make it
%   sparse and finally the signal can be recovered with inverse transform
%   - use Gaussian observation matrix to ensure incoherence with
%   transformation matrix
%
% Author & Date: Yang (i@snowztail.com) - 02 Nov 18
function [a, x, y] = underdetermined_system_generation(m, n, sparseCardinality)
a = normc(randn(m, n));
x = zeros(n, 1);
% sparse support, or index. 'false' ensures no repeat
sparseSupport = randsample(n, sparseCardinality, 'false');
randnTemp = randn(sparseCardinality, 1);
x(sparseSupport) = randnTemp;
y = a * x;
end

