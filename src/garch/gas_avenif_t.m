function [m, l, u] = gas_avenif_t(x, Theta)
% [m, l, u] = gas_avenif_t(x, Theta) computes the values of the news impact
% function by averaging over those given by sampled parameters.
%
% % Input:
% x     - vector of points in the domain.
% Theta - matrix of MCMC output.
%
% Output:
% m     - vector of posterior means.
% l     - vector of posterior quantiles at 0.025 level.
% u     - vector of posterior quantiles at 0.975 level.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   November 14, 2016

    sX = size(x);
    nX = max(sX);
    m = zeros(sX);
    l = zeros(sX);
    u = zeros(sX);
    for i = 1:nX
        nu = Theta(:, 1);
        alpha1 = Theta(:, 4);
        alpha2 = Theta(:, 5);
        beta = Theta(:, 6);
        y = nif(x(i), nu, alpha1, alpha2, beta);
        m(i) = mean(y);
        l(i) = quantile(y, 0.025);
        u(i) = quantile(y, 0.975);
    end
end

function y = nif(x, nu, alpha1, alpha2, beta)
    u = (nu + 1) .* (x .^ 2) ./ (nu - 2 + (x .^ 2));
    y = alpha1 .* u + ...
        alpha2 .* u .* double(x < 0) + ...
        beta;
end
