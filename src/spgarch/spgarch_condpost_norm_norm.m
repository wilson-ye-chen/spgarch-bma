function [logPost sigmaIn sigmaFore] = spgarch_condpost_norm_norm( ...
    theta, m, r, k, c, sigmaSq0, mn, sd)
% [logPost sigmaIn sigmaFore] = spgarch_condpost_norm_norm(theta, ...
% m, r, k, c, sigmaSq0, mn, sd) evaluates the kernel of the conditional
% posterior distribution of the SPGARCH-Normal model.
%
% Input:
% theta    - row vector of parameters of the model indexed by m.
% m        - binary vector for model indexing.
% r        - vector of returns.
% k        - vector of knots in the full model.
% c        - row vector of constants used for computing the expectation
%            of the quadratic-spline in the full model.
% sigmaSq0 - variance of the first period.
% mn       - row vector of means of the normal prior of the knot
%            coefficients in the full model.
% sd       - row vector of standard deviations of the normal prior of
%            the knot coefficients in the full model.
%
% Output:
% logPost  - log-density of the posterior distribution.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   November 18, 2013

    iK = logical(m(6:end));
    kM = k(iK);
    cM = c(iK);
    mnM = mn(iK);
    sdM = sd(iK);
    [logLike, sigmaIn, sigmaFore] = spgarch_like_norm( ...
        r, kM, cM, sigmaSq0, ...
        theta(1), ...
        theta(2), ...
        theta(3:end));
    logPrior = spgarch_prior_norm(theta(6:end), mnM, sdM);
    logPost = logLike + logPrior;
end
