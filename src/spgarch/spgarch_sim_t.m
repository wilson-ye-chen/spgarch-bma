function [Sigma, R] = spgarch_sim_t( ...
    nu, mu, omega, spCoef, k, sigmaSq0, nObs, nSim)
% [Sigma, R] = spgarch_sim_t(nu, mu, omega, spCoef, k, sigmaSq0, nObs, nSim)
% simulates conditional standard deviations and returns from a SPGARCH-t
% model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   March 12, 2014

    S = trnd(nu, nObs, nSim);
    Epsilon = sqrt((nu - 2) ./ nu) .* S;
    SigmaSq = zeros(nObs, nSim);
    
    SigmaSq(1, :) = sigmaSq0;
    for i = 2:nObs
        SigmaSq(i, :) = omega + (SigmaSq((i - 1), :) .* ...
            quadspline(Epsilon((i - 1), :), spCoef, k));
    end
    
    Sigma = sqrt(SigmaSq);
    R = mu + (Sigma .* Epsilon);
end
