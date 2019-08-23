function gjr_sim_job(dataFile, outFile, iSet)
% gjr_sim_job(dataFile, outFile, iSet) is the top-level function for
% running the simulation study of the GJR-t model. This file should be
% used as the main file for the Matlab compiler.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 12, 2016

    load(dataFile);
    REst = R(1:(end - 1), :);
    iSet = str2num(iSet);
    rng('shuffle', 'twister');
    rngState = rng();
    [Sigma, xNif, YNif, accRate, Chain] = ...
        gjr_batest_t_flat(REst, iSet);
    save(outFile, ...
        'iSet', 'rngState', ...
        'Sigma', 'xNif', 'YNif', 'accRate', 'Chain');
end
