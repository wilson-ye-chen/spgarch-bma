function [sigma, pers] = uncsd_dgp2()
% [sigma, pers] = uncsd_dgp2() computes the true unconditional standard
% deviation of DGP2 used for the simulation study of the SPGARCH model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   October 14, 2016

    nu = 8;
    omega = 0.1;
    spCoef = [0.85, 0, 0.1];
    k = [];
    [sigmaSq, pers] = spgarch_uncvar_t(nu, omega, spCoef, k);
    sigma = sqrt(sigmaSq);
end
