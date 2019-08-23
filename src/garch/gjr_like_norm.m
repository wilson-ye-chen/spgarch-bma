function [logLike sigmaIn sigmaFore] = gjr_like_norm( ...
    r, sigmaSq0, mu, omega, alpha1, alpha2, beta)
% [logLike sigmaIn sigmaFore] = gjr_like_norm(r, sigmaSq0, mu, omega, ...
% alpha1, alpha2, beta) computes the log-likelihood of the GJR-GARCH-Normal
% model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   December 7, 2013

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
    logLike   = sum(log(normpdf(a, 0, sigmaIn)));
end
