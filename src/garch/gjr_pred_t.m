function [sigmaPred, nuPred, muPred, predLike] = gjr_pred_t( ...
    r, funEst, winEst, intEst, sdTol, iStart, iEnd)
% [sigmaPred, nuPred, muPred, predLike] = gjr_pred_t(r, funEst, winEst, ...
% intEst, sdTol, iStart, iEnd) computes one-step-ahead forecasts and the
% log-predictive-likelihoods of the GJR-GARCH-t model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   March 10, 2014

    % Initialise outputs
    nPred = iEnd - iStart + 1;
    sigmaPred = zeros(nPred, 1);
    nuPred = zeros(nPred, 1);
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
        [sigmaNext, nuNext, muNext] = next(rPred, Theta);
        
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
            Theta = funEst(rEst);
        end
    end
end

function [sigmaNext, nuNext, muNext] = next(r, Theta)
    nTheta = size(Theta, 1);
    sigmaNext = zeros(nTheta, 1);
    sigmaSq0 = var(r);
    for i = 1:nTheta
        mu = Theta(i, 2);
        omega = Theta(i, 3);
        alpha1 = Theta(i, 4);
        alpha2 = Theta(i, 5);
        beta = Theta(i, 6);
        a = r - mu;
        sigmaSq = gjr_sigmasq(a, sigmaSq0, omega, alpha1, alpha2, beta);
        sigmaNext(i) = sqrt(sigmaSq(end));
    end
    nuNext = Theta(:, 1);
    muNext = Theta(:, 2);
end

function y = t3pdf(x, nu, mu, sigma)
    scale = sigma .* sqrt((nu - 2) ./ nu);
    y = (1 ./ scale) .* tpdf((x - mu) ./ scale, nu);
end
