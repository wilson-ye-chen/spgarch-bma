function [sigmaPred, nuPred, muPred, predLike] = gjr_pred_t_flat( ...
    r, winEst, intEst, sdTol, iStart, iEnd)
% [sigmaPred, nuPred, muPred, predLike] = gjr_pred_t_flat(r, winEst, ...
% intEst, sdTol, iStart, iEnd) is a convenient wrapper of the function
% "gjr_pred_t".
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   April 14, 2014

    % Estimation settings
    theta0 = [8, 0, 0.1, 0.1, 0, 0.8];
    nIter = 55000;
    nDiscard = 5000;
    
    % Handle to sampler
    funEst = @(r)gjr_est_t_flat(r, theta0, nIter, nDiscard);
    
    % Forecast
    [sigmaPred, nuPred, muPred, predLike] = gjr_pred_t( ...
        r, funEst, winEst, intEst, sdTol, iStart, iEnd);
end
