function logPrior = spgarch_prior_unif(kCoef, l, u)
% logPrior = spgarch_prior_unif(kCoef, l, u) computes the log-density
% of the uniform prior distribution of the knot coefficients of the
% SPGARCH model. kCoef, l, and u must be of the same size.
%
% Input:
% kCoef    - vector of knot coefficients.
% l        - vector of lower bounds.
% u        - vector of upper bounds.
%
% Output:
% logPrior - log-density of the prior distribution.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   October 25, 2013

    logPrior = sum(log(unifpdf(kCoef, l, u)));
end
