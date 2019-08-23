function d = mad(Y, T)
% d = mad(Y, T) computes the MAD between Y and T, where Y and T are
% matrices of the same size, with rows corresponding to observations,
% and with columns corresponding to variables.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   May 31, 2016

    d = mean(abs(Y - T), 1);
end
