function [Chain, accept, nAdapt] = rwmetropadapt( ...
    kernelfun, start0, scale0, Sigma0, nIter0, nDiscard0, ...
    targAcc, accTol, nTune, nIter, ...
    regConst, minAdapt, maxAdapt, sdTol)
% [Chain, accept, nAdapt] = rwmetropadapt(kernelfun, start0, scale0, ...
% Sigma0, nIter0, nDiscard0, targAcc, accTol, nTune, nIter, regConst, ...
% minAdapt, maxAdapt, sdTol)
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   November 11, 2013

    % Number of parameter dimensions
    nDim = numel(start0);
    
    % Initial run of the random-walk sampler
    [Chain, accept] = rwmetroptune(kernelfun, start0, ...
        scale0, Sigma0, targAcc, accTol, nTune, nIter0);
    start = Chain(end, :);
    S = cov(Chain((nDiscard0 + 1):end, :));
    
    % Regularize if needed
    [Sigma, flag] = regularize(S, regConst);
    if flag == -1
        warning('regularization failed!');
    elseif flag > 0
        warning('regularized by adding %.4e', regConst(flag));
    end
    
    % Initial marginal standard deviations
    sdOld = sqrt(diag(S));
    
    % Adaptive iterations
    nAdapt = 0;
    stop = (maxAdapt == 0);
    while ~stop
        [Chain, accept] = rwmetroptune(kernelfun, start, ...
            scale0, Sigma, targAcc, accTol, nTune, nIter);
        start = Chain(end, :);
        S = cov(Chain);
        
        % Regularize if needed
        [Sigma, flag] = regularize(S, regConst);
        if flag == -1
            warning('regularization failed!');
        elseif flag > 0
            warning('regularized by adding %.4e', regConst(flag));
        end
        
        % Increment adaptive iteration count
        nAdapt = nAdapt + 1;
        
        % Convergence is measured by the change in marginal standard
        % deviations of the chain
        sd = sqrt(diag(S));
        mape = mean(abs((sd - sdOld) ./ sdOld));
        sdOld = sd;
        
        % Stopping conditions
        if (nAdapt >= minAdapt && mape <= sdTol) || nAdapt >= maxAdapt
            stop = true;
        end
    end
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
