function [Sigma, xNif, YNif, accRate, Chain] = garch_batest_t_flat(Set, iSet)
% [Sigma, xNif, YNif, accRate, Chain] = garch_batest_t_flat(Set, iSet)
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 22, 2016

    % Estimation settings
    theta0 = [8, 0, 0.1, 0.1, 0.8];
    nIter = 55000;
    nDiscard = 5000;
    
    % Points at which the estimated news impact function are evaluated
    xNif = -4:0.01:4;
    
    % Initialise outputs
    nBat = numel(iSet);
    Sigma = zeros(size(Set, 1) + 1, nBat);
    YNif = zeros(numel(xNif), nBat);
    accRate = zeros(1, nBat);
    Chain = zeros(nIter - nDiscard, numel(theta0), nBat);
    
    % Loop through the batch
    for i = 1:nBat
        r = Set(:, iSet(i));
        
        % Simulate from posterior
        [Theta, accept] = garch_est_t_flat(r, theta0, nIter, nDiscard);
        
        % Compute estimated conditional standard deviations
        sigmaSq0 = var(r);
        Sigma(:, i) = garch_avesigma_t(Theta, r, sigmaSq0);
        
        % Evaluate the estimated news impact function
        YNif(:, i) = garch_avenif_t(xNif, Theta);
        
        % Save acceptance rate and sampled parameters
        accRate(i) = sum(accept) ./ numel(accept);
        Chain(:, :, i) = Theta;
    end
end
