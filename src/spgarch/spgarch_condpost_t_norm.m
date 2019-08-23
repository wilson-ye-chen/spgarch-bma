function [logPost, sigmaIn, sigmaFore] = spgarch_condpost_t_norm( ...
    theta, m, r, k, C, nuC, sigmaSq0, mn, sd)
% [logPost, sigmaIn, sigmaFore] = spgarch_condpost_t_norm(theta, m, ...
% r, k, C, nuC, sigmaSq0, mn, sd) evaluates the kernel of the conditional
% posterior distribution of the SPGARCH-t model.
%
% Input:
% theta    - row vector of parameters of the model indexed by m.
% m        - binary vector for model indexing.
% r        - vector of returns.
% k        - vector of knots in the full model.
% C        - matrix of constants used for computing the expectation of the
%            quadratic-spline, whose rows correspond to degrees-of-freedom,
%            and whose columns correspond to knots.
% nuC      - vector of degrees-of-freedom correspond to rows of C.
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
% Date:   May 8, 2014

    iK = logical(m(7:end));
    kM = k(iK);
    CM = C(:, iK);
    mnM = mn(iK);
    sdM = sd(iK);
    [logLike, sigmaIn, sigmaFore] = spgarch_like_t( ...
        r, kM, CM, nuC, sigmaSq0, ...
        theta(1), ...
        theta(2), ...
        theta(3), ...
        theta(4:end));
    logPrior = spgarch_prior_norm_t( ...
        theta(1), ...
        theta(7:end), ...
        mnM, sdM);
    logPost = logLike + logPrior;
end
