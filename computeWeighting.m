function [result] = computeWeighting(d, h, sigma, patchSize)
    %Implement weighting function from the slides
    %Be careful to normalise/scale correctly!
    
    %REPLACE THIS
    result = exp(-(max(d^2 - 2*((sigma)^2),0)/(h^2))) * (1/(patchSize^2));
end