function entry = spgarch_makeprop_t_norm( ...
    m, theta0, r, k, C, nuC, sigmaSq0, mn, sd, regConst)
% entry = spgarch_makeprop_t_norm(m, theta0, r, k, C, nuC, sigmaSq0, mn, ...
% sd, regConst) builds the conditional proposal distribution of parameter
% given model, using an adaptive random-walk Metropolis algorithm.
%
% Input:
% m        - binary vector for model indexing.
% theta0   - row vector of initial parameter values used for optimisation.
% r        - vector of returns.
% k        - vector of knots in the full model.
% C        - matrix of constants used for computing the expectation of the
%            quadratic-spline, whose rows correspond to degrees-of-freedom,
%            and whose columns correspond to knots.
% nuC      - vector of degrees-of-freedom correspond to rows of C.
% sigmaSq0 - variance of the first period.
% mn       - row vector of means of the normal prior of the knot coefficients
%            in the full model.
% sd       - row vector of standard deviations of the normal prior of the
%            knot coefficients in the full model.
% regConst - vector of regularization constants.
%
% Output:
% entry    - structure containing fields:
% .mu      - mean of the proposal distribution.
% .Sigma   - covariance matrix of the proposal distribution.
% .regFlag - regularization flag.
% .accRate - acceptance rate of the random-walk chain.
% .nAdapt  - number of adaptive iterations taken.
% .model   - binary vector indexing the model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   May 8, 2014

    % Settings for the adaptive random-walk sampler
    nDim = sum(m);
    scale0 = 2.38 ./ sqrt(nDim);
    Sigma0 = eye(nDim);
    nIter0 = 25000;
    nDiscard0 = 5000;
    targAcc = 0.234;
    accTol = 0.075;
    nTune = 200;
    nIter = 20000;
    regConstRw = nDim ./ nIter;
    minAdapt = 2;
    maxAdapt = 20;
    sdTol = 0.05;
    
    % Select k, C, mn, sd and theta0 for the model
    iM = logical(m);
    kM = k(iM(7:end));
    CM = C(:, iM(7:end));
    mnM = mn(iM(7:end));
    sdM = sd(iM(7:end));
    theta0M = theta0(iM);
    
    % Conditional log-posterior
    kernel = @(theta) ...
        spgarch_like_t(r, kM, CM, nuC, sigmaSq0, ...
        theta(1), theta(2), theta(3), theta(4:end)) + ...
        spgarch_prior_norm_t(theta(1), theta(7:end), ...
        mnM, sdM);
    
    % Run the adaptive random-walk sampler
    [Chain, accept, nAdapt] = rwmetropadapt( ...
        kernel, theta0M, scale0, Sigma0, nIter0, nDiscard0, ...
        targAcc, accTol, nTune, nIter, ...
        regConstRw, minAdapt, maxAdapt, sdTol);
    
    % Compute sample covariance matrix
    S = cov(Chain);
    
    % Regularize covariance matrix if needed
    [Sigma, flag] = regularize(S, regConst);
    if flag == -1
        warning('regularization failed!');
    elseif flag > 0
        warning('regularized by adding %.4e', regConst(flag));
    end
    
    % Create output structure
    entry.mu = mean(Chain, 1);
    entry.Sigma = Sigma;
    entry.regFlag = flag;
    entry.accRate = sum(accept) ./ nIter;
    entry.nAdapt = nAdapt;
    entry.model = m;
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
