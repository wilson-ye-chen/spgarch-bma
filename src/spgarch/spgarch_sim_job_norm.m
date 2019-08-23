function spgarch_sim_job_norm(dataFile, outFile, iSet)
% spgarch_sim_job_norm(dataFile, outFile, iSet) is the top-level function
% for running the simulation study of the SPGARCH-Normal model. This file
% should be used as the main file for the Matlab compiler.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   March 6, 2016

    load(dataFile);
    REst = R(1:(end - 1), :);
    iSet = str2num(iSet);
    rng('shuffle', 'twister');
    rngState = rng();
    [Sigma, xSpl, YSpl, accRate, Chain, Model] = ...
        spgarch_batest_norm_norm(REst, iSet);
    save(outFile, ...
        'iSet', 'rngState', ...
        'Sigma', 'xSpl', 'YSpl', 'accRate', 'Chain', 'Model');
end
