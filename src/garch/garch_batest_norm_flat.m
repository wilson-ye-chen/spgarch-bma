function [Sigma, xNif, YNif] = garch_batest_norm_flat(Set, iSet)
% [Sigma, xNif, YNif] = garch_batest_norm_flat(Set, iSet)
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   December 8, 2013

    % Estimation settings
    theta0 = [0, 0.1, 0.1, 0.8];
    nIter = 55000;
    nDiscard = 5000;
    
    % Points at which the estimated news impact function are evaluated
    xNif = -4:0.01:4;
    
    % Initialise outputs
    nBat = numel(iSet);
    Sigma = zeros(size(Set, 1), nBat);
    YNif = zeros(numel(xNif), nBat);
    
    % Loop through the batch
    for i = 1:nBat
        r = Set(:, iSet(i));
        
        % Simulate from posterior
        Theta = garch_est_norm_flat(r, theta0, nIter, nDiscard);
        
        % Compute estimated conditional standard deviations
        sigmaSq0 = var(r);
        sigmaAve = garch_avesigma(Theta, r, sigmaSq0);
        Sigma(:, i) = sigmaAve(1:(end - 1));
        
        % Evaluate the estimated news impact function
        YNif(:, i) = garch_avenif(xNif, Theta);
    end
end
