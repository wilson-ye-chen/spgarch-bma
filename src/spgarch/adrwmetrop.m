function [Chain, accept, nAdapt] = adrwmetrop( ...
    kernelfun, start0, Sigma0, nIter, maxAdapt, accTol)
% [Chain, accept, nAdapt] = adrwmetrop(kernelfun, start0, Sigma0, ...
% nIter, maxAdapt, accTol)
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date: October 16, 2013

    % Number of parameter dimensions
    nDim = numel(start0);
    
    % Initial run of the random-walk sampler
    [Chain, accept] = rwmetrop(kernelfun, start0, Sigma0, nIter);
    oldAccRate = sum(accept) ./ nIter;
    
    % Adaptive iterations
    for i = 1:maxAdapt
        start = mean(Chain, 1);
        Sigma = ((2.38 .^ 2) ./ nDim) .* cov(Chain);
        [Chain, accept] = rwmetrop(kernelfun, start, Sigma, nIter);
        accRate = sum(accept) ./ nIter;
        
        % Check stopping criterion
        if abs((accRate - oldAccRate) ./ oldAccRate) <= accTol
            break
        else
            oldAccRate = accRate;
        end
    end
    
    % Number of adaptive iterations
    nAdapt = i;
end
