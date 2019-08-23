function gas_est_job(prefix, outDir)
% gas_est_job(prefix, outDir) generates posterior samples of the
% Beta-t-GARCH (or GAS-t) model using real datasets.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   January 22, 2019

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

    for i = 1:10
        load([prefix, key{i}, '.mat']);
        rng('shuffle', 'twister');
        rngState = rng();
        [Sigma, xNif, YNif, accRate, Chain] = gas_batest_t_flat(r, 1);
        save([outDir, '/gas_est_', key{i}, '.mat'], ...
            'rngState', 'D', 'r', ...
            'Sigma', 'xNif', 'YNif', 'accRate', 'Chain');
        disp(['GAS: ', key{i}, '... done.']);
    end
end
