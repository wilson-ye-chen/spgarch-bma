function c = spgarch_cval(k)
% c = spgarch_cval(k) computes the constants used for calculating
% the expectation of a quadratic-spline with respect to the standard
% Normal distribution.
%
% Author: Wilson Y. Chen
% Date:   August 14, 2013

    c = (-1 ./ sqrt(2 .* pi) .* exp(-(k .^ 2) ./ 2) .* k) + ...
        ((1 ./ 2) .* (1 + k .^ 2) .* erfc(k ./ sqrt(2)));
end
