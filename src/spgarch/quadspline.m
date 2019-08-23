function y = quadspline(x, Coef, k)
% y = quadspline(x, Coef, k) evaluates the quadratic-spline at each of the
% values in vector x. The quadratic-spline is of the form:
%
% y = Coef(:, 1) +
%     Coef(:, 2) * x +
%     Coef(:, 3) * x^2 +
%     Coef(:, 3 + 1) * (x - k(1))^2 * ind(1) + ... +
%     Coef(:, 3 + K) * (x - k(K))^2 * ind(K),
%
% where ind(i) = 1 if x >= k(i), ind(i) = 0 otherwise. When x is a vector,
% Coef must also be a vector; when x is a scalar, Coef can be a matrix,
% where each row can be a distinct set of coefficients.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   June 18, 2016

    y = Coef(:, 1) + ...
        (Coef(:, 2) .* x) + ...
        (Coef(:, 3) .* (x .^ 2));
    for i = 1:numel(k)
        ind = double(x >= k(i));
        y = y + (Coef(:, 3 + i) .* ((x - k(i)) .^ 2) .* ind);
    end
end
