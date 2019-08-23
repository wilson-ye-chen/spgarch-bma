function [sigmaPred, muPred, predLike] = spgarch_pred_norm_norm( ...
    r, winEst, intEst, sdTol, iStart, iEnd)
% [sigmaPred, muPred, predLike] = spgarch_pred_norm_norm(r, winEst, ...
% intEst, sdTol, iStart, iEnd) is a convenient wrapper of the function
% "spgarch_pred_norm".
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   December 8, 2013

    % Estimation settings
    k = norminv((0.1:0.1:0.9), 0, 1);
    theta0 = [0, 0.1, 0.8, 0, 0.01, zeros(1, 9)];
    mn = zeros(1, 9);
    sd = repmat(50, 1, 9);
    m0 = [ones(1, 5), 1, 0, 1, 0, 1, 0, 1, 0, 1];
    prior = @(m)0;
    p = 0.1;
    nIter = 550000;
    nDiscard = 50000;
    
    % Handle to sampler
    funEst = @(r)spgarch_est_norm_norm( ...
        r, k, theta0, mn, sd, m0, prior, p, nIter, nDiscard);
    
    % Forecast
    [sigmaPred, muPred, predLike] = spgarch_pred_norm( ...
        r, k, funEst, winEst, intEst, sdTol, iStart, iEnd);
end
