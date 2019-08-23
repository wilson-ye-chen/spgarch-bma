function [dic, dAve, d, pD] = garch_dic_t(Theta, r, sigmaSq0)
% [dic, dAve, d, pD] = garch_dic_t(Theta, r, sigmaSq0) computes the DIC from
% MCMC outputs for the GARCH-t model.
%
% Input:
% Theta    - matrix of observed parameter vectors, where each row is an
%            observation, and each column is a parameter.
% r        - vector of returns.
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
        alpha = Theta(i, 4);
        beta = Theta(i, 5);
        ll(i) = garch_like_t(r, sigmaSq0, nu, mu, omega, alpha, beta);
    end
    dAve = mean(-2 .* ll);
    
    % Deviance at posterior mean
    thetaAve = mean(Theta, 1);
    nu = thetaAve(1);
    mu = thetaAve(2);
    omega = thetaAve(3);
    alpha = thetaAve(4);
    beta = thetaAve(5);
    ll = garch_like_t(r, sigmaSq0, nu, mu, omega, alpha, beta);
    d = -2 .* ll;
    
    % DIC
    pD = dAve - d;
    dic = dAve + pD;
end
