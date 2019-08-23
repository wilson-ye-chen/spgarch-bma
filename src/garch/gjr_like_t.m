function [logLike sigmaIn sigmaFore] = gjr_like_t( ...
    r, sigmaSq0, nu, mu, omega, alpha1, alpha2, beta)
% [logLike sigmaIn sigmaFore] = gjr_like_t(r, sigmaSq0, nu, mu, omega, ...
% alpha1, alpha2, beta) computes the log-likelihood of the GJR-GARCH-t
% model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   May 4, 2014

    % Degrees-of-freedom constraint
    if nu <= 2 || nu > 200
        logLike   = -inf;
        sigmaIn   = [];
        sigmaFore = [];
        return
    end
    
    % Positivity constraints
    if omega <= 0 || alpha1 < 0 || alpha1 + alpha2 < 0 || beta < 0
        logLike   = -inf;
        sigmaIn   = [];
        sigmaFore = [];
        return
    end
    
    % Stationarity constraint
    if alpha1 + (0.5 .* alpha2) + beta >= 1
        logLike   = -inf;
        sigmaIn   = [];
        sigmaFore = [];
        return
    end
    
    % Compute the conditional variances
    a = r - mu;
    sigmaSq = gjr_sigmasq(a, sigmaSq0, omega, alpha1, alpha2, beta);
    
    sigmaIn   = sqrt(sigmaSq(1:(end - 1)));
    sigmaFore = sqrt(sigmaSq(end));
    scale     = sigmaIn .* sqrt((nu - 2) ./ nu);
    logLike   = sum(log((1 ./ scale) .* tpdf(a ./ scale, nu)));
end
