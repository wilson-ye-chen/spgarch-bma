%%
% File: table_est_sim.m
% Generate the table of summary statistics of parameter estimates
% given by posterior means for simulated datasets.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   June 24, 2016
%%

key{1} = 'garch_dgp1';
key{2} = 'gjr_dgp1';
key{3} = 'gas_dgp1';
key{4} = 'spgarch_dgp1';
key{5} = 'garch_dgp2';
key{6} = 'gjr_dgp2';
key{7} = 'gas_dgp2';
key{8} = 'spgarch_dgp2';

nuTrue = 8;
muTrue = 0;
omTrue = 0.1;

T = zeros(12, 10);
for i = 1:8
    load([key{i}, '.mat']);
    nu = M(:, 1);
    mu = M(:, 2);
    om = M(:, 3);
    if i <= 4
        rowNu = i;
        rowMu = i + 4;
        rowOm = i + 8;
        col = 1:5;
    else
        rowNu = i - 4;
        rowMu = i;
        rowOm = i + 4;
        col = 6:10;
    end
    T(rowNu, col) = [ ...
        mean(nu), ...
        std(nu), ...
        quantile(nu, 0.025), ...
        quantile(nu, 0.975), ...
        rmse(nu, nuTrue)];
    T(rowMu, col) = [ ...
        mean(mu), ...
        std(mu), ...
        quantile(mu, 0.025), ...
        quantile(mu, 0.975), ...
        rmse(mu, muTrue)];
    T(rowOm, col) = [ ...
        mean(om), ...
        std(om), ...
        quantile(om, 0.025), ...
        quantile(om, 0.975), ...
        rmse(om, omTrue)];
end
disp(T);
