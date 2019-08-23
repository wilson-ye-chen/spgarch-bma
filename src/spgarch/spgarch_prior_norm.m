function logPrior = spgarch_prior_norm(kCoef, mn, sd)
% logPrior = spgarch_prior_norm(kCoef, mn, sd) computes the
% log-density of the normal prior distribution of the knot
% coefficients of the SPGARCH model. kCoef, mu, and sigma must
% be of the same size.
%
% Input:
% kCoef    - vector of knot coefficients.
% mn       - vector of means.
% sd       - vector of standard deviations.
%
% Output:
% logPrior - log-density of the prior distribution.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   November 18, 2013

    logPrior = sum(log(normpdf(kCoef, mn, sd)));
end
