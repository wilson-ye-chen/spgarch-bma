function [sigmaPred, muPred, predLike] = spgarch_pred_norm( ...
    r, k, funEst, winEst, intEst, sdTol, iStart, iEnd)
% [sigmaPred, muPred, predLike] = spgarch_pred_norm(r, k, funEst, ...
% winEst, intEst, sdTol, iStart, iEnd) computes one-step-ahead forecasts
% and log-predictive-likelihoods of the SPGARCH-Normal model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   November 30, 2013

    % Initialise outputs
    nPred = iEnd - iStart + 1;
    sigmaPred = zeros(nPred, 1);
    muPred = zeros(nPred, 1);
    predLike = zeros(nPred, 1);
    
    % Simulate from posterior
    rEst = r((iStart - winEst):(iStart - 1));
    Theta = funEst(rEst);
    
    % For each forecast period
    for i = 1:nPred
        % Corresponding index of the return vector
        iR = iStart + i - 1;
        
        % Generate corresponding forecasts from sampled parameters
        rPred = r((iR - winEst):(iR - 1));
        [sigmaNext, muNext] = next(rPred, k, Theta);
        
        % Averaged forecast
        sigmaPred(i) = mean(sigmaNext);
        muPred(i) = mean(muNext);
        
        % Log predictive likelihood
        predLike(i) = log(mean(normpdf(r(iR), muNext, sigmaNext)));
        
        % Update posterior samples if needed
        z = (r(iR) - muPred(i)) ./ sigmaPred(i);
        if (mod(i, intEst) == 0 || abs(z) >= sdTol) && (i ~= nPred)
            rEst = r((iR - winEst + 1):iR);
            Theta = funEst(rEst);
        end
    end
end

function [sigmaNext, muNext] = next(r, k, Theta)
    nTheta = size(Theta, 1);
    sigmaNext = zeros(nTheta, 1);
    sigmaSq0 = var(r);
    for i = 1:nTheta
        mu = Theta(i, 1);
        omega = Theta(i, 2);
        spCoef = Theta(i, 3:end);
        a = r - mu;
        sigmaSq = spgarch_sigmasq(a, k, sigmaSq0, omega, spCoef);
        sigmaNext(i) = sqrt(sigmaSq(end));
    end
    muNext = Theta(:, 1);
end
