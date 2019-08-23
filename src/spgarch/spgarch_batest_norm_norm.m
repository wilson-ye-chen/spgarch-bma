function [Sigma, xSpl, YSpl, accRate, Chain, Model] = ...
    spgarch_batest_norm_norm(Set, iSet)
% [Sigma, xSpl, YSpl, accRate, Chain, Model] = spgarch_batest_norm_norm( ...
% Set, iSet)
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   March 3, 2016

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
    
    % Points at which the estimated spline are evaluated
    xSpl = -4:0.01:4;
    
    % Initialise outputs
    nBat = numel(iSet);
    Sigma = zeros(size(Set, 1) + 1, nBat);
    YSpl = zeros(numel(xSpl), nBat);
    accRate = zeros(1, nBat);
    Chain = zeros(nIter - nDiscard, numel(theta0), nBat);
    Model = zeros(nIter - nDiscard, numel(m0), nBat);
    
    % Loop through the batch
    for i = 1:nBat
        r = Set(:, iSet(i));
        
        % Simulate from joint-posterior
        [Theta, M, accept] = spgarch_est_norm_norm( ...
            r, k, theta0, mn, sd, m0, prior, p, nIter, nDiscard);
        
        % Compute estimated conditional standard deviations
        sigmaSq0 = var(r);
        Sigma(:, i) = spgarch_avesigma(Theta, k, r, sigmaSq0);
        
        % Evaluate the estimated spline
        YSpl(:, i) = spgarch_avespline(xSpl, Theta, k);
        
        % Save acceptance rate, sampled parameters, and model indices
        accRate(i) = sum(accept) ./ numel(accept);
        Chain(:, :, i) = Theta;
        Model(:, :, i) = M;
    end
end
