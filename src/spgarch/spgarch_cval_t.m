function C = spgarch_cval_t(k, nu)
% C = spgarch_cval_t(k, nu) computes the constants used for calculating
% the expectation of a quadratic-spline with respect to the Student-t
% distribution.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   March 13, 2014

    nK = numel(k);
    nNu = numel(nu);
    C = zeros(nNu, nK);
    for i = 1:nNu
        for j = 1:nK
            fun = @(x)((x - k(j)) .^ 2) .* t3pdf(x, nu(i), 0, 1);
            C(i, j) = integral(fun, k(j), inf);
        end
    end
end

function y = t3pdf(x, nu, mu, sigma)
    scale = sigma .* sqrt((nu - 2) ./ nu);
    y = (1 ./ scale) .* tpdf((x - mu) ./ scale, nu);
end
