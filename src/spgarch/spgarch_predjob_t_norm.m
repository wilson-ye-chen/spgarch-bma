function spgarch_predjob_t_norm(dataFile, outFile, nEst, intEst, iStart, iEnd)
% spgarch_predjob_t_norm(dataFile, outFile, nEst, intEst, iStart, iEnd) is the
% top-level function for running the forecasting study of the SPGARCH-t model.
% This file should be used as the main file for the Matlab compiler.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 27, 2016

    nEst = str2num(nEst);
    intEst = str2num(intEst);
    iStart = str2num(iStart);
    iEnd = str2num(iEnd);
    load(dataFile);
    DPred = D(iStart:iEnd, :);
    rng('shuffle', 'twister');
    rngState = rng();
    [sigmaPred, nuPred, muPred, predLike, Theta, M, accept] = ...
        spgarch_pred_t_norm(r, nEst, intEst, inf, iStart, iEnd);
    save(outFile, ...
        'iStart', 'iEnd', 'DPred', 'rngState', ...
        'sigmaPred', 'nuPred', 'muPred', 'predLike', 'Theta', 'M', 'accept');
end
