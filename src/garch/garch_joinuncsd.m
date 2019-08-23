function [iSamp, m, s, l, u] = garch_joinuncsd(dirName)
% [iSamp, m, s, l, u] = garch_joinuncsd(dirName) joins the unconditional
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
% Date:   July 13, 2016

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
        omega = Chain(:, 3);
        alpha = Chain(:, 4);
        beta = Chain(:, 5);
        uncSd = sqrt(omega ./ (1 - alpha - beta));
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
