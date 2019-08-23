function [Sigma, R] = spgarch_sim_norm( ...
    mu, omega, spCoef, k, sigmaSq0, nObs, nSim)
% [Sigma, R] = spgarch_sim_norm(mu, omega, spCoef, k, sigmaSq0, nObs, nSim)
% simulates conditional standard deviations and returns from a SPGARCH-Normal
% model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   December 8, 2013
    
    Epsilon = normrnd(0, 1, nObs, nSim);
    SigmaSq = zeros(nObs, nSim);
    
    SigmaSq(1, :) = sigmaSq0;
    for i = 2:nObs
        SigmaSq(i, :) = omega + (SigmaSq((i - 1), :) .* ...
            quadspline(Epsilon((i - 1), :), spCoef, k));
    end
    
    Sigma = sqrt(SigmaSq);
    R = mu + (Sigma .* Epsilon);
end
