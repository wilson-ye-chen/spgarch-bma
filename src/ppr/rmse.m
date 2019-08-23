function d = rmse(Y, T)
% d = rmse(Y, T) computes the RMSE between Y and T, where Y and T are
% matrices of the same size, with rows corresponding to observations,
% and with columns corresponding to variables.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   May 31, 2016

    d = sqrt(mean((Y - T) .^ 2, 1));
end
