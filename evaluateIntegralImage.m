function [patchSum] = evaluateIntegralImage(ii, row, col, patchSize)
% This function should calculate the sum over the patch centred at row, col
% of size patchSize of the integral image ii
radius = floor(patchSize/2);
%REPLACE THIS!
L1 = ii(row-radius-1,col-radius-1);
L3 = ii(row+radius,col+radius);
L2 = ii(row-radius-1,col+radius);
L4 = ii(row+radius,col-radius-1);

patchSum = L3 - L2 - L4 + L1;
end