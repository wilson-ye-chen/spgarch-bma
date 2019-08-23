function logPrior = spgarch_prior_norm_t(nu, kCoef, mn, sd)
% logPrior = spgarch_prior_norm_t(nu, kCoef, mn, sd) computes the
% log-kernel of the prior density of the SPGARCH-t model. Gaussian
% priors are used for knot coefficients. The prior for degrees of
% freedom parameter is proportional to nu^(-2), which is flat on
% 1/nu. kCoef, mn, and sd must be of the same size.
%
% Input:
% nu       - degrees of freedom parameter.
% kCoef    - vector of knot coefficients.
% mn       - vector of means.
% sd       - vector of standard deviations.
%
% Output:
% logPrior - log-kernel of the prior density.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   May 5, 2014

    logPrior = log(nu .^ (-2)) + sum(log(normpdf(kCoef, mn, sd)));
end
