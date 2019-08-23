function [m, l, u] = spgarch_avespline_t(x, Theta, k)
% [m, l, u] = spgarch_avespline_t(x, Theta, k) computes the posterior
% summary of the quadratic-spline at each value of x, using the MCMC
% output.
%
% Input:
% x     - vector of points in the domain.
% Theta - matrix of MCMC output.
% k     - vector of knots.
%
% Output:
% m     - vector of posterior means.
% l     - vector of posterior quantiles at 0.025 level.
% u     - vector of posterior quantiles at 0.975 level.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   June 18, 2016

    sX = size(x);
    nX = max(sX);
    m = zeros(sX);
    l = zeros(sX);
    u = zeros(sX);
    for i = 1:nX
        y = quadspline(x(i), Theta(:, 4:end), k);
        m(i) = mean(y);
        l(i) = quantile(y, 0.025);
        u(i) = quantile(y, 0.975);
    end
end
