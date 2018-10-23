function [support] = hard_threshold(columnVector)
[hardThreshold, support] = max(abs(columnVector));
hardThreshold = hardThreshold * sign(columnVector(support));
hardVector = columnVector;
hardVector(hardVector < hardThreshold) = 0;
end

