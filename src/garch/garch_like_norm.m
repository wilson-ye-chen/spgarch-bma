function [logLike sigmaIn sigmaFore] = garch_like_norm( ...
    r, sigmaSq0, mu, omega, alpha, beta)
% [logLike sigmaIn sigmaFore] = garch_like_norm(r, sigmaSq0, mu, omega, ...
% alpha, beta) computes the log-likelihood of the GARCH-Normal model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   November 27, 2013

    % Positivity and stationarity constraints
    if omega <= 0 || alpha < 0 || beta < 0 || alpha + beta >= 1
        logLike   = -inf;
        sigmaIn   = [];
        sigmaFore = [];
        return
    end
    
    % Compute the conditional variances.
    a = r - mu;
    sigmaSq = garch_sigmasq(a, sigmaSq0, omega, alpha, beta);
    
    sigmaIn   = sqrt(sigmaSq(1:(end - 1)));
    sigmaFore = sqrt(sigmaSq(end));
    logLike   = sum(log(normpdf(a, 0, sigmaIn)));
end
