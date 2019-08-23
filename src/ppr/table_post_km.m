%%
% File: table_post_km.m
% Generate the table of the posterior probabilities of the number
% of knots in the submodels.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   June 22, 2016
%%

% Data identifiers
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

% Generate the table
nRow = numel(key);
nCol = 4;
PKm = zeros(nRow, nCol);
for i = 1:numel(key)
    file = ['spgarch_est_', key{i}, '.mat'];
    load(file);
    M = Model(:, 7:end);
    km = sum(M, 2);
    for j = 1:nCol
        PKm(i, j) = sum(km == (j - 1)) ./ numel(km);
    end
end

% Show talbe
disp(PKm);
