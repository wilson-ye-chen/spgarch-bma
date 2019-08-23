function [Chain accept] = rwmetrop(kernelfun, start, Sigma, nIter)
% [Chain accept] = rwmetrop(kernelfun, start, Sigma, nIter) samples from
% a target distribution using the random-walk Metropolis algorithm.
%
% Input:
% kernelfun - handle to the log kernel function of the target density.
% start     - starting point of the Markov chain.
% Sigma     - covariance matrix of the multivariate Gaussian proposal.
% nIter     - number of MCMC iterations.
%
% Output:
% Chain     - Markov chain of points.
% accept    - vector of indicators for whether a move is accepted.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   October 13, 2013

    % Initialize the chain
    Chain = zeros(nIter, numel(start));
    Chain(1, :) = start;
    
    % Evaluate log kernel of starting point
    oldKernel = kernelfun(start);
    
    % Acceptance indicators
    accept = zeros(nIter, 1);
    
    % MCMC Iterations
    for i = 2:nIter
        % Generate a proposal
        proposal = mvnrnd(Chain((i - 1), :), Sigma);
        
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
    end
end
