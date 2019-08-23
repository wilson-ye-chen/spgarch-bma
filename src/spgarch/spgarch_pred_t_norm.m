function [sigmaPred, nuPred, muPred, predLike, Theta, M, accept] = ...
    spgarch_pred_t_norm(r, winEst, intEst, sdTol, iStart, iEnd)
% [sigmaPred, nuPred, muPred, predLike, Theta, M, accept] = ...
% spgarch_pred_t_norm(r, winEst, intEst, sdTol, iStart, iEnd) is a
% convenient wrapper of the function "spgarch_pred_t".
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 6, 2016

    % Estimation settings
    k = tinv((0.1:0.1:0.9), 8) .* sqrt((8 - 2) ./ 8);
    theta0 = [8, 0, 0.1, 0.8, 0, 0.01, zeros(1, 9)];
    mn = zeros(1, 9);
    sd = repmat(50, 1, 9);
    m0 = [ones(1, 6), 1, 0, 1, 0, 1, 0, 1, 0, 1];
    prior = @(m)0;
    p = 0.1;
    nIter = 550000;
    nDiscard = 50000;
    
    % Handle to sampler
    funEst = @(r)spgarch_est_t_norm( ...
        r, k, theta0, mn, sd, m0, prior, p, nIter, nDiscard);
    
    % Forecast
    [sigmaPred, nuPred, muPred, predLike, Theta, M, accept] = ...
        spgarch_pred_t( ...
        r, k, funEst, winEst, intEst, sdTol, iStart, iEnd);
end
