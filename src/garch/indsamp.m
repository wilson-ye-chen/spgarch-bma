function [Chain, accept] = indsamp(kernelfun, start, mu, Sigma, w, s, nIter)
% [Chain, accept] = indsamp(kernelfun, start, mu, Sigma, w, s, nIter) samples
% from a target distribution given its kernel function, using the Independence
% sampler.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   November 30, 2013

    % Initialise outputs
    Chain = zeros(nIter, numel(start));
    accept = zeros(nIter, 1);
    
    % First sample
    Chain(1, :) = start;
    accept(1) = 1;
    
    % Evaluate kernel function
    oldKern = kernelfun(start);
    
    % Evaluate proposal density
    oldProp = log(nmixpdf(start, mu, Sigma, w, s));
    
    % MCMC iterations
    for i = 2:nIter
        % Simulate a point from proposal
        pointSim = nmixrnd(mu, Sigma, w, s);
        
        % Evaluate kernel function
        kern = kernelfun(pointSim);
        
        % Evaluate proposal density
        prop = log(nmixpdf(pointSim, mu, Sigma, w, s));
        
        % Compute the log acceptance probability
        left = kern + oldProp;
        right = oldKern + prop;
        if isequal(left, right)
            accPr = 0;
        else
            accPr = left - right;
        end
        
        % Accept or reject
        if accPr >= 0
            Chain(i, :) = pointSim;
            accept(i) = 1;
            oldKern = kern;
            oldProp = prop;
        elseif log(unifrnd(0, 1)) < accPr
            Chain(i, :) = pointSim;
            accept(i) = 1;
            oldKern = kern;
            oldProp = prop;
        else
            Chain(i, :) = Chain((i - 1), :);
        end
    end
end

function x = nmixrnd(mu, Sigma, w, s)
% x = nmixrnd(mu, Sigma, w, s) generates a random number
% from a scale-mixture of normal distributions.
%
% Input:
% mu    - row vector of means,
% Sigma - covariance matrix,
% w     - row vector of mixture weights,
% s     - row vector of scales.

    b = mnrnd(1, w);
    x = mvnrnd(mu, ((b * s') .* Sigma));
end

function y = nmixpdf(x, mu, Sigma, w, s)
% y = nmixpdf(x, mu, Sigma, w, s) computes the density of
% a scale-mixture of normal distributions.
%
% Input:
% x     - a point on the support,
% mu    - row vector of means,
% Sigma - covariance matrix,
% w     - row vector of mixture weights,
% s     - row vector of scales.

    y = 0;
    for i = 1:length(w)
        y = y + (w(i) .* mvnpdf(x, mu, (s(i) .* Sigma)));
    end
end
