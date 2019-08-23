function [sigma, pers] = uncsd_dgp1()
% [sigma, pers] = uncsd_dgp1() computes the true unconditional standard
% deviation of DGP1 used for the simulation study of the SPGARCH model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   October 14, 2016

    nu = 8;
    omega = 0.1;
    spCoef = [1.1, 0, 0, 0, -0.48, 0.58, 0, 0, 0, 0, 0, 0];
    k = tinv((0.1:0.1:0.9), nu) .* sqrt((nu - 2) ./ nu);
    [sigmaSq, pers] = spgarch_uncvar_t(nu, omega, spCoef, k);
    sigma = sqrt(sigmaSq);
end
