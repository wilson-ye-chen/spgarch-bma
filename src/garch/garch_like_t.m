function [logLike sigmaIn sigmaFore] = garch_like_t( ...
    r, sigmaSq0, nu, mu, omega, alpha, beta)
% [logLike sigmaIn sigmaFore] = garch_like_t(r, sigmaSq0, nu, mu, omega, ...
% alpha, beta) computes the log-likelihood of the GARCH-t model.
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
    scale     = sigmaIn .* sqrt((nu - 2) ./ nu);
    logLike   = sum(log((1 ./ scale) .* tpdf(a ./ scale, nu)));
end
