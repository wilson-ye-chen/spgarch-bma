function logPrior = gas_prior_flat_t(nu)
% logPrior = gas_prior_flat_t(nu) computes the log-kernel of the
% prior density of the GAS-GARCH-t model. The prior for degrees of
% freedom parameter is proportional to nu^(-2), which is flat on
% 1/nu.
%
% Input:
% nu       - degrees of freedom parameter.
%
% Output:
% logPrior - log-kernel of the prior density.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   May 7, 2014

    logPrior = log(nu .^ (-2));
end
