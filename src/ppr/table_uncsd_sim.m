%%
% File: table_uncsd_sim.m
% Generate the table of summary statistics of unconditional standard
% deviation estimates given by posterior means for simulated datasets.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   October 24, 2016
%%

key{1} = 'garch_dgp1';
key{2} = 'gjr_dgp1';
key{3} = 'gas_dgp1';
key{4} = 'spgarch_dgp1';
key{5} = 'garch_dgp2';
key{6} = 'gjr_dgp2';
key{7} = 'gas_dgp2';
key{8} = 'spgarch_dgp2';

sdTrueDgp1 = uncsd_dgp1();
sdTrueDgp2 = uncsd_dgp2();

T = zeros(5, 10);
for i = 1:8
    load(['uncsd_', key{i}, '.mat']);
    if i <= 4
        row = i;
        col = 1:5;
        sdTrue = sdTrueDgp1;
    else
        row = i - 4;
        col = 6:10;
        sdTrue = sdTrueDgp2;
    end
    T(row, col) = [ ...
        mean(m), ...
        std(m), ...
        quantile(m, 0.025), ...
        quantile(m, 0.975), ...
        rmse(m, sdTrue)];
end

% Sample SD
load('data_dgp1.mat');
sd = std(R(1:(end - 1), :), 0, 1)';
T(5, 1:5) = [ ...
    mean(sd), ...
    std(sd), ...
    quantile(sd, 0.025), ...
    quantile(sd, 0.975), ...
    rmse(sd, sdTrueDgp1)];

load('data_dgp2.mat');
sd = std(R(1:(end - 1), :), 0, 1)';
T(5, 6:10) = [ ...
    mean(sd), ...
    std(sd), ...
    quantile(sd, 0.025), ...
    quantile(sd, 0.975), ...
    rmse(sd, sdTrueDgp2)];

disp(T);
