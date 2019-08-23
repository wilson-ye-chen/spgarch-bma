function [sigmaPred, nuPred, muPred, predLike, Theta, M, accept] = ...
    spgarch_pred_t(r, k, funEst, winEst, intEst, sdTol, iStart, iEnd)
% [sigmaPred, nuPred, muPred, predLike, Theta, M, accept] = ...
% spgarch_pred_t(r, k, funEst, winEst, intEst, sdTol, iStart, iEnd)
% computes one-step-ahead forecasts and log-predictive-likelihoods of
% the SPGARCH-t model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 6, 2016

    % Initialise outputs
    nPred = iEnd - iStart + 1;
    sigmaPred = zeros(nPred, 1);
    nuPred = zeros(nPred, 1);
    muPred = zeros(nPred, 1);
    predLike = zeros(nPred, 1);
    
    % Simulate from posterior
    rEst = r((iStart - winEst):(iStart - 1));
    [Theta, M, accept] = funEst(rEst);
    
    % For each forecast period
    for i = 1:nPred
        % Corresponding index of the return vector
        iR = iStart + i - 1;
        
        % Generate corresponding forecasts from sampled parameters
        rPred = r((iR - winEst):(iR - 1));
        [sigmaNext, nuNext, muNext] = next(rPred, k, Theta);
        
        % Averaged forecast
        sigmaPred(i) = mean(sigmaNext);
        nuPred(i) = mean(nuNext);
        muPred(i) = mean(muNext);
        
        % Log predictive likelihood
        predLike(i) = log(mean(t3pdf(r(iR), nuNext, muNext, sigmaNext)));
        
        % Update posterior samples if needed
        z = (r(iR) - muPred(i)) ./ sigmaPred(i);
        if (mod(i, intEst) == 0 || abs(z) >= sdTol) && (i ~= nPred)
            rEst = r((iR - winEst + 1):iR);
            [Theta, M, accept] = funEst(rEst);
        end
    end
end

function [sigmaNext, nuNext, muNext] = next(r, k, Theta)
    nTheta = size(Theta, 1);
    sigmaNext = zeros(nTheta, 1);
    sigmaSq0 = var(r);
    for i = 1:nTheta
        mu = Theta(i, 2);
        omega = Theta(i, 3);
        spCoef = Theta(i, 4:end);
        a = r - mu;
        sigmaSq = spgarch_sigmasq(a, k, sigmaSq0, omega, spCoef);
        sigmaNext(i) = sqrt(sigmaSq(end));
    end
    nuNext = Theta(:, 1);
    muNext = Theta(:, 2);
end

function y = t3pdf(x, nu, mu, sigma)
    scale = sigma .* sqrt((nu - 2) ./ nu);
    y = (1 ./ scale) .* tpdf((x - mu) ./ scale, nu);
end
