%%
% File: table_est_emp.m
% Generate the table of summary statistics of posterior estimates
% for real datasets.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   August 10, 2017
%%

key{1} = 'spx';
key{2} = 'ftse';
key{3} = 'dax';
key{4} = 'n225';
key{5} = 'hsi';
key{6} = 'aapl';
key{7} = 'armh';
key{8} = 'intc';
key{9} = 'nvda';
key{10} = 'sndk';

T = zeros(10, 6);
for i = 1:10
    load(['spgarch_est_', key{i}, '.mat']);
    nu = Chain(:, 1);
    mu = Chain(:, 2);
    T(i, :) = [ ...
        mean(nu), ...
        quantile(nu, 0.025), ...
        quantile(nu, 0.975), ...
        mean(mu), ...
        quantile(mu, 0.025), ...
        quantile(mu, 0.975)];
end
disp(T);
