function run_gengsumm(dirName)
% run_gengsumm(dirName) generates matrix files (.mat) containing the
% summary statistics of the estimated posterior distributions of the
% coefficient function. The directory dirName must contain the input
% files named "spgarch_est_[key].mat".
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   June 18, 2016

    % Data identifiers
    key{1}  = 'spx';
    key{2}  = 'ftse';
    key{3}  = 'dax';
    key{4}  = 'n225';
    key{5}  = 'hsi';
    key{6}  = 'aapl';
    key{7}  = 'armh';
    key{8}  = 'intc';
    key{9}  = 'nvda';
    key{10} = 'sndk';
    
    % Points in the domain
    x = -4:0.01:4;
    
    % Knot positions
    k = tinv((0.1:0.1:0.9), 8) .* sqrt((8 - 2) ./ 8);
    
    % Generate matrix file for each key
    for i = 1:numel(key)
        file = [dirName, '/spgarch_est_', key{i}, '.mat'];
        load(file);
        [m, l, u] = spgarch_avespline_t(x, Chain, k);
        fileOut = [dirName, '/spgarch_g_', key{i}, '.mat'];
        save(fileOut, 'x', 'm', 'l', 'u', 'k');
        disp([key{i}, ' generated.']);
    end
end
