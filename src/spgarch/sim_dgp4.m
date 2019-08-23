function [Sigma, R] = sim_dgp4()
% [Sigma, R] = sim_dgp4() generates a data-set from DGP4 for the
% simulation study of the SPGARCH model. The data-set containes
% 500 simulated conditional volatility series and their corresponding
% return series, with each series containing 4001 observations.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 17, 2017

    nu = 5;
    mu = 0;
    omega = 0.1;
    spCoef = [0.8, 0, 0.25, -0.15];
    k = [0];
    sigmaSq0 = spgarch_uncvar_t(nu, omega, spCoef, k);
    nObs = 4001;
    nSim = 500;
    [Sigma, R] = spgarch_sim_t( ...
        nu, mu, omega, spCoef, k, sigmaSq0, nObs, nSim);
end
