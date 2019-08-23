function sigmaAve = spgarch_avesigma_t(Theta, k, r, sigmaSq0)
% sigmaAve = spgarch_avesigma_t(Theta, k, r, sigmaSq0) computes the
% conditional standard deviations by averaging over those given by sampled
% parameters.
%
% Input:
% Theta    - matrix of observed parameter vectors, where each row is an
%            observation, and each column is a parameter.
% k        - vector of knots in the full model.
% r        - vector of returns.
% sigmaSq0 - variance of the first period.
%
% Output:
% sigmaAve - vector of average conditional standard deviations, containing
%            one more element than the number of returns, where the last
%            element is the out-of-sample one-period-ahead forecast.
%
% Author: Wilson Ye Chen <wilsq.mail@gmail.com>
% Date:   March 15, 2014

    nRet = numel(r);
    nTheta = size(Theta, 1);
    
    sigmaSum = zeros(nRet + 1, 1);
    for i = 1:nTheta
        mu = Theta(i, 2);
        omega = Theta(i, 3);
        spCoef = Theta(i, 4:end);
        a = r - mu;
        sigmaSq = spgarch_sigmasq(a, k, sigmaSq0, omega, spCoef);
        sigmaSum = sigmaSum + sqrt(sigmaSq);
    end
    sigmaAve = sigmaSum ./ nTheta;
end
