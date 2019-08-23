function [dic, dAve, d, pD] = gas_dic_t(Theta, r, sigmaSq0)
% [dic, dAve, d, pD] = gas_dic_t(Theta, r, sigmaSq0) computes the DIC from
% MCMC outputs for the Beta-t-GARCH (or GAS-t) model.
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
        alpha1 = Theta(i, 4);
        alpha2 = Theta(i, 5);
        beta = Theta(i, 6);
        ll(i) = gas_like_t(r, sigmaSq0, nu, mu, omega, alpha1, alpha2, beta);
    end
    dAve = mean(-2 .* ll);
    
    % Deviance at posterior mean
    thetaAve = mean(Theta, 1);
    nu = thetaAve(1);
    mu = thetaAve(2);
    omega = thetaAve(3);
    alpha1 = thetaAve(4);
    alpha2 = thetaAve(5);
    beta = thetaAve(6);
    ll = gas_like_t(r, sigmaSq0, nu, mu, omega, alpha1, alpha2, beta);
    d = -2 .* ll;
    
    % DIC
    pD = dAve - d;
    dic = dAve + pD;
end
