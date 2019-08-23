%%
% File: gen_uncmnsd.m
% Generate the posterior summaries of the unconditional means and
% standard deviations, and save the output to "spgarch_uncmnsd.mat".
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   July 9, 2016
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

% Generate lookup table
nu = 8;
k = tinv((0.1:0.1:0.9), nu) .* sqrt((nu - 2) ./ nu);
nuC = logspace(log10(2.2), log10(200), 10000);
C = spgarch_cval_t(k, nuC);
disp('Lookup table generated.');

% Generate the posterior summaries
nKey = numel(key);
mMu = zeros(nKey, 1);
lMu = zeros(nKey, 1);
uMu = zeros(nKey, 1);
mSd = zeros(nKey, 1);
lSd = zeros(nKey, 1);
uSd = zeros(nKey, 1);
for i = 1:nKey
    load(['spgarch_est_', key{i}, '.mat']);
    mMu(i) = mean(Chain(:, 2));
    lMu(i) = quantile(Chain(:, 2), 0.025);
    uMu(i) = quantile(Chain(:, 2), 0.975);
    [mSd(i), lSd(i), uSd(i)] = spgarch_aveuncsd_t(Chain, C, nuC);
    disp([key{i}, ' generated.']);
end

% Save the output
save('spgarch_uncmnsd.mat', ...
    'mMu', 'lMu', 'uMu', ...
    'mSd', 'lSd', 'uSd');
disp('spgarch_uncmnsd.mat generated.');
