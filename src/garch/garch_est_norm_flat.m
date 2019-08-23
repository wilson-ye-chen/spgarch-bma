function [Theta, accept] = garch_est_norm_flat(r, theta0, nIter, nDiscard)
% [Theta, accept] = garch_est_norm_flat(r, theta0, nIter, nDiscard) simulates
% from the posterior distribution of the GARCH-Normal model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 8, 2014

    % Settings for the adaptive random-walk sampler
    nDim = numel(theta0);
    scale0 = 2.38 ./ sqrt(nDim);
    Sigma0 = eye(nDim);
    nIter0 = 25000;
    nDiscard0 = 5000;
    targAcc = 0.234;
    accTol = 0.075;
    nTune = 200;
    nIterRw = 20000;
    regConstRw = nDim ./ nIterRw;
    minAdapt = 2;
    maxAdapt = 20;
    sdTol = 0.05;
    
    % Log-posterior
    sigmaSq0 = var(r);
    kernel = @(theta)garch_like_norm( ...
        r, sigmaSq0, theta(1), theta(2), theta(3), theta(4));
    
    % Run the adaptive random-walk sampler
    ChainRw = rwmetropadapt( ...
        kernel, theta0, scale0, Sigma0, nIter0, nDiscard0, ...
        targAcc, accTol, nTune, nIterRw, ...
        regConstRw, minAdapt, maxAdapt, sdTol);
    
    % Compute sample covariance matrix
    S = cov(ChainRw);
    
    % Regularize covariance matrix if needed
    regConst = [1, 10, 100, 1e5, 1e10] .* eps;
    [Sigma, flag] = regularize(S, regConst);
    if flag == -1
        warning('regularization failed!');
    elseif flag > 0
        warning('regularized by adding %.4e', regConst(flag));
    end
    
    % Run the independence sampler
    mu = mean(ChainRw, 1);
    w = [0.85, 0.1, 0.05];
    s = [1, 10, 100];
    [Theta, accept] = indsamp(kernel, mu, mu, Sigma, w, s, nIter);
    
    % Discard a few initial samples
    Theta = Theta((nDiscard + 1):end, :);
    accept = accept((nDiscard + 1):end);
end

function [Sigma, flag] = regularize(S, regConst)
% [Sigma, flag] = regularize(S, regConst) adds a small positive
% constant to the diagonal elements of S, if sample covariance
% matrix is not positive definite or ill-conditioned.
%
% Input:
% S        - sample covariance matrix.
% regConst - vector of regularization constants.
%
% Output:
% Sigma    - regularized covariance matrix.
% flag     - exit flag is set to -1 if regularization is failed,
%            to 0 if S is unaltered, and to an index to regConst
%            if the corresponding constant is added.

    nDim = size(S, 1);
    nReg = numel(regConst);
    
    Sigma = S;
    i = 1;
    while i <= nReg && ispoorscale(Sigma)
        Sigma = S + (regConst(i) .* eye(nDim));
        i = i + 1;
    end
    
    if ispoorscale(Sigma)
        Sigma = eye(nDim);
        flag = -1;
    else
        flag = i - 1;
    end
end

function isPoor = ispoorscale(S)
    [~, notPd] = chol(S);
    isPoor = notPd || cond(S) >= (1 ./ eps);
end
