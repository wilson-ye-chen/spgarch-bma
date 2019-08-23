function spgarch_est_job(dataFile, outFile)
% spgarch_est_job(dataFile, outFile) is the top-level function for running
% the estimation study of the SPGARCH-t model. This file should be used as
% the main file for the Matlab compiler.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 27, 2016

    load(dataFile);
    rng('shuffle', 'twister');
    rngState = rng();
    [Sigma, xSpl, YSpl, accRate, Chain, Model] = ...
        spgarch_batest_t_norm(r, 1);
    save(outFile, ...
        'D', 'r', 'rngState', ...
        'Sigma', 'xSpl', 'YSpl', 'accRate', 'Chain', 'Model');
end
