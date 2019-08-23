function [Theta, M, accept] = varselmh( ...
    condpost, makeprop, prior, iSel, m0, p, dict, w, s, nIter)
% [Theta, M, accept] = varselmh(condpost, makeprop, prior, iSel, ...
% m0, p, dict, w, s, nIter) generates samples from the joint posterior
% distribution over the "parameter-model" space, using a Metropolis-
% Hastings algorithm.
%
% Input:
% condpost    - handle to the log kernel function of the conditional
%               posterior distribution of parameter given model.
% makeprop    - handle to a function that builds the conditional proposal
%               distribution of parameter given model.
% prior       - handle to the log kernel function of the prior distribution
%               of the model.
% iSel        - vector of indices of the coefficients corresponding to
%               the variables being considered for selection.
% m0          - binary vector for the initial model.
% p           - the probability of proposing to include a variable when
%               it is currently not included, and vice versa (e.g., 0.1).
% dict        - map container containing information about the conditional
%               proposal distributions of parameter given model.
% w           - row vector of mixture weights of the mixture of Gaussian
%               conditional proposal distributions of parameter given model
%               (e.g., [0.85, 0.1, 0.05]).
% s           - row vector of scales of the mixture of Gaussian conditional
%               proposal distributions of parameter given model (e.g., [1,
%               10, 100]).
% nIter       - number of iterations the Metropolis-Hastings algorithm is
%               ran for variable selection (e.g., 500,000).
%
% Output:
% Theta       - matrix of samples from the joint posterior distribution
%               over the "parameter-model" space, where rows correspond to
%               samples.
% M           - matrix of binary vectors used for model indexing.
% accept      - vector of indicators for whether a move is accepted.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   November 15, 2013

    % Full dimension of the model
    nDim = numel(m0);
    
    % Initialise outputs
    Theta = zeros(nIter, nDim);
    M = zeros(nIter, nDim);
    accept = zeros(nIter, 1);
    
    % Compute key for m0
    key = bi2de(m0);
    
    % If entry exists for m0
    if isKey(dict, key)
        % Lookup from dictionary
        entry = dict(key);
    else
        % Build proposal distribution
        entry = makeprop(m0);
        dict(key) = entry;
    end
    
    % Always accept m0
    Theta(1, logical(m0)) = entry.mu;
    M(1, :) = m0;
    accept(1) = 1;
    
    % Compute the posterior
    oldPost = condpost(entry.mu, m0) + prior(m0);
    
    % Compute the proposal density
    oldProp = log(nmixpdf(entry.mu, entry.mu, entry.Sigma, w, s));
    
    % MCMC iterations
    for i = 2:nIter
        % Simulate a binary vector. This proposal distribution
        % is symmetrical.
        mSim = ones(1, nDim);
        mSim(iSel) = binornd(1, abs(M((i - 1), iSel) - p));
        
        % Compute key
        key = bi2de(mSim);
        
        % If entry exists
        if isKey(dict, key)
            % Lookup from dictionary
            entry = dict(key);
        else
            % Build proposal distribution
            entry = makeprop(mSim);
            dict(key) = entry;
        end
        
        % Simulate from proposal distribution
        thetaSim = nmixrnd(entry.mu, entry.Sigma, w, s);
        
        % Compute the posterior
        post = condpost(thetaSim, mSim) + prior(mSim);
        
        % Compute the proposal density
        prop = log(nmixpdf(thetaSim, entry.mu, entry.Sigma, w, s));
        
        % Compute the log acceptance probability
        left = post + oldProp;
        right = oldPost + prop;
        if isequal(left, right)
            accPr = 0;
        else
            accPr = left - right;
        end
        
        % Accept or reject
        if accPr >= 0
            Theta(i, find(mSim)) = thetaSim;
            M(i, :) = mSim;
            accept(i) = 1;
            oldPost = post;
            oldProp = prop;
        elseif log(unifrnd(0, 1)) < accPr
            Theta(i, find(mSim)) = thetaSim;
            M(i, :) = mSim;
            accept(i) = 1;
            oldPost = post;
            oldProp = prop;
        else
            Theta(i, :) = Theta((i - 1), :);
            M(i, :) = M((i - 1), :);
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
