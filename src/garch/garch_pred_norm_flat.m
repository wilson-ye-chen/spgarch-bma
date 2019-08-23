function [sigmaPred, muPred, predLike] = garch_pred_norm_flat( ...
    r, winEst, intEst, sdTol, iStart, iEnd)
% [sigmaPred, muPred, predLike] = garch_pred_norm_flat(r, winEst, ...
% intEst, sdTol, iStart, iEnd) is a convenient wrapper of the function
% "garch_pred_norm".
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   December 8, 2013

    % Estimation settings
    theta0 = [0, 0.1, 0.1, 0.8];
    nIter = 55000;
    nDiscard = 5000;
    
    % Handle to sampler
    funEst = @(r)garch_est_norm_flat(r, theta0, nIter, nDiscard);
    
    % Forecast
    [sigmaPred, muPred, predLike] = garch_pred_norm( ...
        r, funEst, winEst, intEst, sdTol, iStart, iEnd);
end
