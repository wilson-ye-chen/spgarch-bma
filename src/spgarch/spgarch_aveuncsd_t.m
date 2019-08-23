function [m, l, u, uncSd] = spgarch_aveuncsd_t(Theta, C, nuC)
% [m, l, u, uncSd] = spgarch_aveuncsd_t(Theta, C, nuC) computes the
% posterior summaries of the unconditional standard deviation of the
% SPGARCH-t model using the MCMC output.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   July 9, 2016

    nTheta = size(Theta, 1);
    uncSd = zeros(nTheta, 1);
    for i = 1:nTheta
        nu = Theta(i, 1);
        omega = Theta(i, 3);
        spCoef = Theta(i, 4:end);
        uncVar = spgarch_uncvar_tf(nu, omega, spCoef, C, nuC);
        uncSd(i) = sqrt(uncVar);
    end
    m = mean(uncSd);
    l = quantile(uncSd, 0.025);
    u = quantile(uncSd, 0.975);
end
