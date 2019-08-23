function [D, r] = importeod_yahoo(date, last)
% [D, r] = importeod_yahoo(date, last) computes percentage log-returns
% from the Yahoo end-of-day price data.
%
% Input:
% date - column oriented cell array of dates in yyyy-mm-dd format.
% last - column vector of adjusted closing prices.
%
% Output:
% D    - matrix of date vectors.
% r    - vector of percentage log-returns.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 27, 2016

    date = flipud(date);
    last = flipud(last);
    D = datevec(date, 'yyyy-mm-dd');
    D = D(2:end, 1:3);
    r = diff(log(last)) .* 100;
end
