%%
% File: table_dic.m
% Generate the table of DIC estimates for real datasets. The averaged DIC
% is used for the SP-GARCH model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   December 14, 2016
%%

model{1} = 'garch';
model{2} = 'gjr';
model{3} = 'gas';
model{4} = 'spgarch';

data{1} = 'spx';
data{2} = 'ftse';
data{3} = 'dax';
data{4} = 'n225';
data{5} = 'hsi';
data{6} = 'aapl';
data{7} = 'armh';
data{8} = 'intc';
data{9} = 'nvda';
data{10} = 'sndk';

% Generate lookup table
nu = 8;
k = tinv((0.1:0.1:0.9), nu) .* sqrt((nu - 2) ./ nu);
nuC = logspace(log10(2.2), log10(200), 10000);
C = spgarch_cval_t(k, nuC);
disp('Lookup table generated.');

% Compute DIC estimates
nModel = numel(model);
nData = numel(data);
T = zeros(nModel .* 3, nData);
for i = 1:nModel
    for j = 1:nData
        load([model{i}, '_est_', data{j}, '.mat']);
        if strcmp(model{i}, 'garch')
            [dic, dAve, d, pD] = garch_dic_t(Chain, r, var(r));
        elseif strcmp(model{i}, 'gjr')
            [dic, dAve, d, pD] = gjr_dic_t(Chain, r, var(r));
        elseif strcmp(model{i}, 'gas')
            [dic, dAve, d, pD] = gas_dic_t(Chain, r, var(r));
        elseif strcmp(model{i}, 'spgarch')
            [dic, dAve, d, pD] = spgarch_dic_ave_t( ...
                Chain, Model, r, k, C, nuC, var(r));
        end
        T(i, j) = dic;
        T(nModel + i, j) = dAve;
        T(2 .* nModel + i, j) = pD;
        disp(['(', model{i}, ', ', data{j}, ') added.']);
    end
end

% Save table
save('dic.mat', 'T');
disp(T);
