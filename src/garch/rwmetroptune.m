function [Chain, accept, scale] = rwmetroptune( ...
    kernelfun, start, scale0, Sigma, targAcc, accTol, nTune, nIter)
% [Chain, accept, scale] = rwmetroptune(kernelfun, start, scale0, ...
% Sigma, targAcc, accTol, nTune, nIter) samples from a target distribution
% using the random-walk Metropolis algorithm. The scale of the proposal
% covariance matrix is tuned to obtain a target acceptance rate.
%
% Input:
% kernelfun - handle to the log kernel function of the target density.
% start     - starting point of the Markov chain.
% scale0    - initial scale (e.g., 2.38 / sqrt(d)).
% Sigma     - covariance matrix of the multivariate Gaussian proposal.
% targAcc   - target acceptance rate (e.g., 0.234).
% accTol    - acceptance rate tolerance (e.g., 0.075).
% nTune     - number of tuning iterations (e.g., 500).
% nIter     - number of MCMC iterations.
%
% Output:
% Chain     - Markov chain of points.
% accept    - vector of indicators for whether a move is accepted.
% scale     - tuned scale.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   November 7, 2013

    % Initialize the chain
    Chain = zeros(nIter, numel(start));
    Chain(1, :) = start;
    
    % Evaluate log kernel of starting point
    oldKernel = kernelfun(start);
    
    % Initial scale
    scale = scale0;
    
    % Acceptance indicators
    accept = zeros(nIter, 1);
    
    % MCMC Iterations
    for i = 2:nIter
        % Generate a proposal
        proposal = mvnrnd(Chain((i - 1), :), (scale .^ 2) .* Sigma);
        
        % Compute the log acceptance probability
        kernel = kernelfun(proposal);
        accPr = kernel - oldKernel;
        
        % Accept or reject
        if accPr >= 0
            Chain(i, :) = proposal;
            oldKernel = kernel;
            accept(i) = 1;
        elseif log(unifrnd(0, 1)) < accPr
            Chain(i, :) = proposal;
            oldKernel = kernel;
            accept(i) = 1;
        else
            Chain(i, :) = Chain((i - 1), :);
        end
        
        % Tune the scale of the proposal distribution
        if ~mod(i, nTune)
            tempAccept = accept((i - nTune + 1):i);
            accRate = sum(tempAccept) ./ nTune;
            if abs(accRate - targAcc) > accTol
                accRate = min(max(accRate, eps), 1 - eps);
                scale = scale .* norminv(targAcc ./ 2, 0, 1) ./ ...
                    norminv(accRate ./ 2, 0, 1);
            end
        end
    end
end
