function [g, t, B, yyHat] = spgarch_ls(y, k, nIter)
% [g, t, B, yyHat] = spgarch_ls(y, k, nIter) estimates the SPGARCH model
% using a least-square approach suggested by an anonymous reviewer. This
% implementation relies on CPLEX to solve the least-square problem with
% linear constraints.
%
% Input:
% y     - vector of zero-mean returns.
% k     - vector of knots.
% nIter - number of iterations.
%
% Output:
% g     - coefficient function evaluated over a grid of size 500.
% t     - vector of 500 grid points over which NIF is evaluated.
% B     - matrix of parameter estimates over iterations.
% yyHat - vector of estimated squared returns.
%
% Date: January 2, 2019

    % Initial innovations from standard GARCH
    y = y(:);
    mdl = garch(1, 1);
    est = estimate(mdl, y);
    ss = infer(est, y);
    er = y ./ sqrt(ss);

    % Estimate parameters using squared returns
    nObs = numel(y);
    nKnt = numel(k);
    o = ones(nObs - 1, 1);
    z = repmat(1e-8, nObs - 1, 1);
    yy = y .^ 2;
    B = zeros(nKnt + 4, nIter);
    for i = 1:nIter
        YyRep = repmat(yy(1:(end - 1)), 1, nKnt + 3);
        X = [o, spdsgn(er(1:(end - 1)), k) .* YyRep];
        B(:, i) = cplexlsqlin(X, yy(2:end), -X, -z);
        yyHat = [ss(1); X * B(:, i)];
        er = y ./ sqrt(yyHat);
    end

    % Estimated NIF
    t = linspace(-3, 3, 500)';
    g = spdsgn(t, k) * B(2:end, end);
end

function X = spdsgn(va, vk)
% X = spdsgn(va, vk) returns the design matrix of a
% quadratic regression spline.
%
% Input:
% va - vector of arguments.
% vk - vector of knots.

    nObs = numel(va);
    nKnt = numel(vk);
    va = va(:);
    vk = vk(:)';
    A = repmat(va, 1, nKnt);
    K = repmat(vk, nObs, 1);
    o = ones(nObs, 1);
    X = [o, va, va .^ 2, ((A - K) .^ 2) .* double(A >= K)];
end
