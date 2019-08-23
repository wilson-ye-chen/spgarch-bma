function [Sigma, R] = gas_sim_t( ...
    nu, mu, omega, alpha1, alpha2, beta, sigmaSq0, nObs, nSim)
% [Sigma, R] = spgarch_sim_t(nu, mu, omega, alpha1, alpha2, beta, ...
% sigmaSq0, nObs, nSim) simulates conditional standard deviations and
% returns from a Beta-t-GARCH model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 11, 2017

    S = trnd(nu, nObs, nSim);
    Epsilon = sqrt((nu - 2) ./ nu) .* S;
    SigmaSq = zeros(nObs, nSim);
    
    U = (nu + 1) .* Epsilon .^ 2 ./ (nu - 2 + Epsilon .^ 2);
    Ind = double(Epsilon < 0);
    
    SigmaSq(1, :) = sigmaSq0;
    for i = 2:nObs
        prevSigmaSq = SigmaSq((i - 1), :);
        prevU = U((i - 1), :);
        prevInd = Ind((i - 1), :);
        SigmaSq(i, :) = ...
            omega + ...
            alpha1 .* prevSigmaSq .* prevU + ...
            alpha2 .* prevSigmaSq .* prevU .* prevInd + ...
            beta .* prevSigmaSq;
    end
    
    Sigma = sqrt(SigmaSq);
    R = mu + (Sigma .* Epsilon);
end
