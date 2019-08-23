function [logLike sigmaIn sigmaFore] = spgarch_like_norm( ...
    r, k, c, sigmaSq0, mu, omega, spCoef)
% [logLike sigmaIn sigmaFore] = spgarch_like_norm(r, k, c, sigmaSq0, ...
% mu, omega, spCoef) computes the log-likelihood of the SPGARCH model under
% the Normal distribution.
%
% Input:
% c      - row vector of constants used for computing the expectation of the
%          quadratic-spline.
% spCoef - row vector of spline coefficients.
%
% Author: Wilson Y. Chen <yche5077@uni.sydney.edu.au>
% Date:   October 23, 2013

    % Stationarity constraints
    if omega <= 0
        logLike   = -inf;
        sigmaIn   = [];
        sigmaFore = [];
        return
    end
    spExp = spCoef(1) + spCoef(3) + (spCoef(4:end) * c');
    if spExp <= 0 || spExp >= 1
        logLike   = -inf;
        sigmaIn   = [];
        sigmaFore = [];
        return
    end
    
    % Compute the conditional variances.
    a = r - mu;
    [sigmaSq allPos] = spgarch_sigmasq(a, k, sigmaSq0, omega, spCoef);
    
    % Positivity constraint
    if ~allPos
        logLike   = -inf;
        sigmaIn   = [];
        sigmaFore = [];
        return
    end
    
    sigmaIn   = sqrt(sigmaSq(1:(end - 1)));
    sigmaFore = sqrt(sigmaSq(end));
    logLike   = sum(log(normpdf(a, 0, sigmaIn)));
end
