function [iSamp, M, S, L, U, x, Y, Sig, acc] = garch_joinsimjob(dirName)
% [iSamp, M, S, L, U, x, Y, Sig, acc] = garch_joinsimjob(dirName) joins
% the result files in a single directory generated by the simulation jobs.
% The directory must contain only the result files.
%
% Input:
% dirName - directory name.
%
% Output:
% iSamp   - sample index.
% M       - matrix of posterior means.
% S       - matrix of posterior standard deviations.
% L       - matrix of the lower-bound of the 95-percent posterior interval.
% U       - matrix of the upper-bound of the 95-percent posterior interval.
% x       - vector of points at which the coefficient function is evaluated.
% Y       - matrix of function values of the coefficient function.
% Sig     - matrix of conditional volatilities.
% acc     - vector of acceptance rates.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   May 20, 2016

    nDim = 5;
    nObs = 4001;
    
    x = -4:0.01:4;
    nX = numel(x);
    
    file = dir(dirName);
    nFile = numel(file) - 2;
    
    iSamp = zeros(nFile, 1);
    M = zeros(nFile, nDim);
    S = zeros(nFile, nDim);
    L = zeros(nFile, nDim);
    U = zeros(nFile, nDim);
    Y = zeros(nFile, nX);
    Sig = zeros(nFile, nObs);
    acc = zeros(nFile, 1);
    
    for i = 1:nFile
        load([dirName, '/', file(i + 2).name]);
        iSamp(i) = iSet;
        M(i, :) = mean(Chain(:, (1:nDim)), 1);
        S(i, :) = std(Chain(:, (1:nDim)), 0, 1);
        L(i, :) = quantile(Chain(:, (1:nDim)), 0.025, 1);
        U(i, :) = quantile(Chain(:, (1:nDim)), 0.975, 1);
        Y(i, :) = YNif;
        Sig(i, :) = Sigma;
        acc(i, :) = accRate;
        disp([file(i + 2).name, ' appended.']);
    end
    
    [iSamp, iSort] = sort(iSamp, 'ascend');
    M = M(iSort, :);
    S = S(iSort, :);
    L = L(iSort, :);
    U = U(iSort, :);
    Y = Y(iSort, :);
    Sig = Sig(iSort, :);
    acc = acc(iSort);
end