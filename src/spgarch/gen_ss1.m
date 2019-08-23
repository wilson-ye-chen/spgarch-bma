%%
% File: gen_ss1.m
% Purpose:
% This script generates a sub-sample (sub-series) of 1500 observations
% from each of the empirical data files.
%
% Author: Wilson Ye Chen <ye.chen@uts.edu.au>
% Date:   January 15, 2019
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

for i = 1:numel(key)
    load(['data_', key{i}, '.mat']);
    n = numel(r);
    s = n - 2500;
    t = n - 1001;
    r = r(s:t);
    D = D(s:t, :);
    save(['data_ss1_', key{i}, '.mat'], 'r', 'D');
    disp([ ...
        num2str(D(1, 1)), '/', ...
        num2str(D(1, 2)), '/', ...
        num2str(D(1, 3)), ' -- ', ...
        num2str(D(end, 1)), '/', ...
        num2str(D(end, 2)), '/', ...
        num2str(D(end, 3)), ' :: ', ...
        key{i}]);
end
