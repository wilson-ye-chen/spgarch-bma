function [iSamp, m, s, l, u] = spgarch_joinuncsd(dirName)
% [iSamp, m, s, l, u] = spgarch_joinuncsd(dirName) joins the unconditional
% standard deviations using the result files in a single directory generated
% by the simulation jobs. The directory must contain only the result files.
%
% Input:
% dirName - directory name.
%
% Output:
% iSamp   - sample index.
% m       - vector of posterior means.
% s       - vector of posterior standard deviations.
% l       - vector of the lower-bound of the 95-percent posterior interval.
% u       - vector of the upper-bound of the 95-percent posterior interval.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   October 14, 2016

    
    % Generate lookup table
    nu = 8;
    k = tinv((0.1:0.1:0.9), nu) .* sqrt((nu - 2) ./ nu);
    nuC = logspace(log10(2.2), log10(200), 10000);
    C = spgarch_cval_t(k, nuC);
    disp('Lookup table generated.');
    
    % Loop through files under directory
    file = dir(dirName);
    nFile = numel(file) - 2;
    
    iSamp = zeros(nFile, 1);
    m = zeros(nFile, 1);
    s = zeros(nFile, 1);
    l = zeros(nFile, 1);
    u = zeros(nFile, 1);
    
    for i = 1:nFile
        load([dirName, '/', file(i + 2).name]);
        iSamp(i) = iSet;
        [~, ~, ~, uncSd] = spgarch_aveuncsd_t(Chain, C, nuC);
        m(i) = mean(uncSd);
        s(i) = std(uncSd);
        l(i) = quantile(uncSd, 0.025);
        u(i) = quantile(uncSd, 0.975);
        disp([file(i + 2).name, ' appended.']);
    end
    
    [iSamp, iSort] = sort(iSamp, 'ascend');
    m = m(iSort);
    s = s(iSort);
    l = l(iSort);
    u = u(iSort);
end
