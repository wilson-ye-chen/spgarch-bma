function [Theta, M, accept, xSpl, ySpl] = spgarch_clustest_norm_norm( ...
    Set, name, iSet)
% [Theta, M, accept, xSpl, ySpl] = spgarch_clustest_norm_norm(Set, ...
% name, iSet) simulates from the joint-posterior distribution of the
% SPGARCH-Normal model, over the "parameter-knot" space, computes points
% on the spline using the sampled parameters, saves the results to a file,
% and plots the estimated spline. The full model has 9 knots placed on the
% deciles of the standard normal distribution.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   December 5, 2013

    % Estimation settings
    r = Set(:, iSet);
    k = norminv((0.1:0.1:0.9), 0, 1);
    theta0 = [0, 0.1, 0.8, 0, 0.01, zeros(1, 9)];
    mn = zeros(1, 9);
    sd = repmat(50, 1, 9);
    m0 = [ones(1, 5), 1, 0, 1, 0, 1, 0, 1, 0, 1];
    prior = @(m)0;
    p = 0.1;
    nIter = 550000;
    nDiscard = 50000;
    
    % Simulate from joint-posterior
    [Theta, M, accept] = spgarch_est_norm_norm( ...
        r, k, theta0, mn, sd, m0, prior, p, nIter, nDiscard);
    
    % Compute points on the estimated spline
    xSpl = -4:0.01:4;
    ySpl = spgarch_avespline(xSpl, Theta, k);
    
    % Save results
    save(name{iSet}, 'Theta', 'M', 'accept', 'xSpl', 'ySpl');
    
    % Plot the estimated spline
    figure;
    plot(xSpl, ySpl, '-k', 'LineWidth', 0.8);
end
