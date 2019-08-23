function [Sigma, R] = sim_dgp3()
% [Sigma, R] = sim_dgp3() generates a data-set from DGP3 for the
% simulation study of the SPGARCH model. The data-set containes
% 500 simulated conditional volatility series and their corresponding
% return series, with each series containing 4001 observations.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 20, 2017

    nu       = 5;
    mu       = 0;
    omega    = 0.1;
    alpha1   = 0.15;
    alpha2   = 0;
    beta     = 0.82;
    sigmaSq0 = omega ./ (1 - alpha1 - 0.5 .* alpha2 - beta);
    nObs     = 4001;
    nSim     = 500;
    [Sigma, R] = gas_sim_t( ...
        nu, mu, omega, alpha1, alpha2, beta, sigmaSq0, nObs, nSim);
end
