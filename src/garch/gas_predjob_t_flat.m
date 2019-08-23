function gas_predjob_t_flat(dataFile, outFile, nEst, intEst, iStart, iEnd)
% gas_predjob_t_flat(dataFile, outFile, nEst, intEst, iStart, iEnd) is the
% top-level function for running the forecasting study of the GAS-t model.
% This file should be used as the main file for the Matlab compiler.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 11, 2016

    nEst = str2num(nEst);
    intEst = str2num(intEst);
    iStart = str2num(iStart);
    iEnd = str2num(iEnd);
    load(dataFile);
    DPred = D(iStart:iEnd, :);
    rng('shuffle', 'twister');
    rngState = rng();
    [sigmaPred, nuPred, muPred, predLike] = gas_pred_t_flat( ...
        r, nEst, intEst, inf, iStart, iEnd);
    save(outFile, ...
        'iStart', 'iEnd', 'DPred', 'rngState', ...
        'sigmaPred', 'nuPred', 'muPred', 'predLike');
end
