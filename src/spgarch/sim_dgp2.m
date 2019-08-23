function [Sigma, R] = sim_dgp2()
% [Sigma, R] = sim_dgp2() generates a data-set from DGP2 for the
% simulation study of the SPGARCH model. The data-set containes
% 500 simulated conditional volatility series and their corresponding
% return series, with each series containing 4001 observations.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   July 1, 2014

    nu = 8;
    mu = 0;
    omega = 0.1;
    spCoef = [0.85, 0, 0.1];
    k = [];
    sigmaSq0 = spgarch_uncvar_t(nu, omega, spCoef, k);
    nObs = 4001;
    nSim = 500;
    [Sigma, R] = spgarch_sim_t( ...
        nu, mu, omega, spCoef, k, sigmaSq0, nObs, nSim);
end
