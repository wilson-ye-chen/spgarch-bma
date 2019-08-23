function [logLike sigmaIn sigmaFore] = spgarch_like_t( ...
    r, k, C, nuC, sigmaSq0, nu, mu, omega, spCoef)
% [logLike sigmaIn sigmaFore] = spgarch_like_t(r, k, C, nuC, sigmaSq0, ...
% nu, mu, omega, spCoef) computes the log-likelihood of the SPGARCH model.
% The innovations are assumed to follow a Student-t distribution.
%
% Input:
% C      - matrix of constants used for computing the expectation of the
%          quadratic-spline, whose rows correspond to degrees-of-freedom,
%          and whose columns correspond to knots.
% nuC    - vector of degrees-of-freedom correspond to rows of C.
% spCoef - row vector of spline coefficients.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   May 4, 2014

    % Degrees-of-freedom constraint
    if nu < nuC(1) || nu > nuC(end)
        logLike   = -inf;
        sigmaIn   = [];
        sigmaFore = [];
        return
    end
    
    % Stationarity constraints
    if omega <= 0
        logLike   = -inf;
        sigmaIn   = [];
        sigmaFore = [];
        return
    end
    [~, iC] = min(abs(nuC - nu));
    c = C(iC, :);
    spExp = spCoef(1) + spCoef(3) + (spCoef(4:end) * c');
    if spExp <= 0 || spExp >= 1
        logLike   = -inf;
        sigmaIn   = [];
        sigmaFore = [];
        return
    end
    
    % Compute the conditional variances
    a = r - mu;
    [sigmaSq, allPos] = spgarch_sigmasq(a, k, sigmaSq0, omega, spCoef);
    
    % Positivity constraint
    if ~allPos
        logLike   = -inf;
        sigmaIn   = [];
        sigmaFore = [];
        return
    end
    
    sigmaIn   = sqrt(sigmaSq(1:(end - 1)));
    sigmaFore = sqrt(sigmaSq(end));
    scale     = sigmaIn .* sqrt((nu - 2) ./ nu);
    logLike   = sum(log((1 ./ scale) .* tpdf(a ./ scale, nu)));
end
