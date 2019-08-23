function [dic, dAve, d, pD] = spgarch_dic_ave_t( ...
    Theta, M, r, k, C, nuC, sigmaSq0)
% [dic, dAve, d, pD] = spgarch_dic_ave_t(Theta, M, r, k, C, nuC, sigmaSq0)
% computes the averaged DIC from MCMC output for the SPGARCH-t model.
%
% Input:
% Theta    - matrix of observed parameter vectors, where each row is an
%            observation, and each column is a parameter.
% M        - matrix of observed binary vectors, whose size is the same as
%            the size of Theta.
% r        - vector of returns.
% k        - vector of knots in the full model.
% C        - matrix of constants used for computing the expectation of the
%            quadratic-spline, whose rows correspond to degrees-of-freedom,
%            and whose columns correspond to knots.
% nuC      - vector of degrees-of-freedom correspond to rows of C.
% sigmaSq0 - variance of the first period.
%
% Output:
% dic      - value of the averaged DIC.
% dAve     - expected posterior mean of deviance.
% d        - expected deviance at posterior mean.
% pD       - expected effective number of parameters.
%
% Author: Wilson Ye Chen <wilsq.mail@gmail.com>
% Date:   December 14, 2016

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
    
    % Deviance at posterior mean for each model
    [~, ~, tau] = unique(M(:, 7:end), 'rows');
    maxTau = max(tau);
    pTau = zeros(maxTau, 1);
    d = zeros(maxTau, 1);
    for i = 1:maxTau
        iTheta = (tau == i);
        pTau(i) = sum(iTheta) ./ nTheta;
        thetaAve = mean(Theta(iTheta, :), 1);
        nu = thetaAve(1);
        mu = thetaAve(2);
        omega = thetaAve(3);
        spCoef = thetaAve(4:end);
        ll = spgarch_like_t(r, k, C, nuC, sigmaSq0, nu, mu, omega, spCoef);
        d(i) = -2 .* ll;
    end
    
    % Averaged DIC
    pD = dAve - (d' * pTau);
    dic = dAve + pD;
end
