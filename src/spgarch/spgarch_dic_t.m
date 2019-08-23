function [dic, dAve, d, pD] = spgarch_dic_t(Theta, r, k, C, nuC, sigmaSq0)
% [dic, dAve, d, pD] = spgarch_dic_t(Theta, r, k, C, nuC, sigmaSq0) computes
% the DIC from MCMC outputs for the SPGARCH-t model.
%
% Input:
% Theta    - matrix of observed parameter vectors, where each row is an
%            observation, and each column is a parameter.
% r        - vector of returns.
% k        - vector of knots in the full model.
% C        - matrix of constants used for computing the expectation of the
%            quadratic-spline, whose rows correspond to degrees-of-freedom,
%            and whose columns correspond to knots.
% nuC      - vector of degrees-of-freedom correspond to rows of C.
% sigmaSq0 - variance of the first period.
%
% Output:
% dic      - value of the DIC.
% dAve     - posterior mean of deviance.
% d        - deviance at posterior mean.
% pD       - effective number of parameters.
%
% Author: Wilson Ye Chen <wilsq.mail@gmail.com>
% Date:   November 8, 2016

    nRet = numel(r);
    nTheta = size(Theta, 1);
    
    % Posterior mean of deviance
    ll = zeros(nTheta, 1);
    for i = 1:nTheta
        nu = Theta(i, 1);
        mu = Theta(i, 2);
        omega = Theta(i, 3);
        spCoef = Theta(i, 4:end);
        ll(i) = spgarch_like_t(r, k, C, nuC, sigmaSq0, nu, mu, omega, spCoef);
    end
    dAve = mean(-2 .* ll);
    
    % Deviance at posterior mean
    thetaAve = mean(Theta, 1);
    nu = thetaAve(1);
    mu = thetaAve(2);
    omega = thetaAve(3);
    spCoef = thetaAve(4:end);
    ll = spgarch_like_t(r, k, C, nuC, sigmaSq0, nu, mu, omega, spCoef);
    d = -2 .* ll;
    
    % DIC
    pD = dAve - d;
    dic = dAve + pD;
end
