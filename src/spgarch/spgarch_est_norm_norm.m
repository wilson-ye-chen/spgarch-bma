function [Theta, M, accept] = spgarch_est_norm_norm( ...
    r, k, theta0, mn, sd, m0, prior, p, nIter, nDiscard)
% [Theta, M, accept] = spgarch_est_norm_norm(r, k, theta0, mn, sd, m0, ...
% prior, p, nIter, nDiscard) simulates from the joint-posterior distribution
% of the SPGARCH-Normal model, over the "parameter-knot" space.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   November 25, 2013

    c = spgarch_cval(k);
    sigmaSq0 = var(r);
    regConst = [1, 10, 100, 1e5, 1e10] .* eps;
    w = [0.85, 0.1, 0.05];
    s = [1, 10, 100];
    iSel = 6:numel(theta0);
    dict = emptydict();
    
    condpost = @(theta, m)spgarch_condpost_norm_norm( ...
        theta, m, r, k, c, sigmaSq0, mn, sd);
    makeprop = @(m)spgarch_makeprop_norm_norm( ...
        m, theta0, r, k, c, sigmaSq0, mn, sd, regConst);
    [Theta, M, accept] = varselmh( ...
        condpost, makeprop, prior, iSel, m0, p, dict, w, s, nIter);
    
    Theta = Theta((nDiscard + 1):end, :);
    M = M((nDiscard + 1):end, :);
    accept = accept((nDiscard + 1):end);
end
