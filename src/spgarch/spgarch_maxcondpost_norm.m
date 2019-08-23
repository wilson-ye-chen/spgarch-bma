function [theta, H, exitFlag] = spgarch_maxcondpost_norm( ...
    m, theta0, r, k, c, sigmaSq0, l, u)
% [theta, H, exitFlag] = spgarch_maxcondpost_norm(m, theta0, r, k, c, ...
% sigmaSq0, l, u) finds the mode of the conditional posterior distribution
% of the SPGARCH-Normal model using numerical optimisation.
%
% Input:
% m        - binary vector for model indexing.
% theta0   - row vector of initial parameter values used for optimisation.
% r        - vector of returns.
% k        - vector of knots in the full model.
% c        - row vector of constants used for computing the expectation of
%            the quadratic-spline in the full model.
% sigmaSq0 - variance of the first period.
% l        - row vector of lower bounds of the uniform prior of the knot
%            coefficients in the full model.
% u        - row vector of upper bounds of the uniform prior of the knot
%            coefficients in the full model.
%
% Output:
% theta    - the mode of the conditional posterior distribution.
% H        - the Hessian matrix of the negative conditional log-posterior
%            density evaluated at the mode.
% exitFlag - exit flag of the numerical optimiser, indicating the state of
%            convergence.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   October 28, 2013

    % Optimiser options
    opt = optimset( ...
        'Algorithm', 'interior-point', ...
        'FinDiffType', 'central', ...
        'UseParallel', 'never', ...
        'MaxIter', 10000, ...
        'MaxFunEvals', 50000, ...
        'Display', 'off');
    
    % Select k, c, a, b and theta0 for the model
    iK = find(m(6:end));
    kM = k(iK);
    cM = c(iK);
    lM = l(iK);
    uM = u(iK);
    theta0M = theta0([1:5, (5 + iK)]);
    
    % Negative conditional log-posterior
    fun = @(theta)-( ...
        spgarch_like_norm( ...
        r, kM, cM, sigmaSq0, theta(1), theta(2), theta(3:end)) + ...
        spgarch_prior_unif( ...
        theta(6:end), lM, uM));
    
    % Construct matrices for linear inequality constraints
    nK = numel(kM);
    
    AKCoefL = [zeros(nK, 5), -eye(nK)];
    AKCoefU = [zeros(nK, 5), eye(nK)];
    aSpExpL = [0, 0, -1, 0, -1, -cM];
    aSpExpU = [0, 0, 1, 0, 1, cM];
    aOmegaL = [0, -1, 0, 0, 0, zeros(1, nK)];
    
    bKCoefL = -lM';
    bKCoefU = uM';
    bSpExpL = 0 - eps;
    bSpExpU = 1 - eps;
    bOmegaL = 0 - eps;
    
    A = [AKCoefL; AKCoefU; aSpExpL; aSpExpU; aOmegaL];
    b = [bKCoefL; bKCoefU; bSpExpL; bSpExpU; bOmegaL];
    
    % Find mode and curvature of conditional log-posterior
    [theta, ~, exitFlag, ~, ~, ~, H] = fmincon( ...
        fun, theta0M, A, b, [], [], [], [], [], opt);
end
