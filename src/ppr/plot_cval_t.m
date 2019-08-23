%%
% File: plot_cval_t.m
% Purpose:
% Plots the constants used for computing the persistence of
% the SPGARCH-t model.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   February 1, 2017
%%

% Override the subplot function
subplot = @(m, n, p)subaxis(m, n, p, ...
    'ML', 0.14, ...
    'MB', 0.16, ...
    'MR', 0.04, ...
    'MT', 0.04);

color2    = [0, 0, 0];
color3    = [0.95, 0, 0];
color8    = [0, 0, 0];
colorNorm = [0, 0, 1];
lnWd      = 1;

% Compute c values
if exist('C') ~= 1
    k = tinv([0.1:0.1:0.9], 8) .* sqrt((8 - 2) ./ 8);
    nuC = logspace(log10(2.2), log10(200), 10000);
    C = spgarch_cval_t(k, nuC);
    cNorm = spgarch_cval(k);
end

% Look for the row corresponding to nu = 3 and nu = 8
[~, i3] = min(abs(nuC - 3));
[~, i8] = min(abs(nuC - 8));

% Generate plot
figure();
subplot(1, 1, 1);
hold on;
plot(k, C(1, :), '-.', 'color', color2, 'linewidth', lnWd);
plot(k, C(i3, :), '--', 'color', color3, 'linewidth', lnWd);
plot(k, C(i8, :), '-', 'color', color8, 'linewidth', lnWd);
plot(k, cNorm, 's', 'color', colorNorm, 'linewidth', lnWd);
axis([-1.5, 1.5, -0.05, 2.53]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
xlabel('$k_{i}$', 'interpreter', 'latex', 'fontsize', 13);
ylabel('$c_{i}$', 'interpreter', 'latex', 'fontsize', 13);
h = legend( ...
    '$\nu = 2.2$', ...
    '$\nu = 3$', ...
    '$\nu = 8$', ...
    'Normal (analytical)', ...
    'location', 'northeast');
set(h, 'interpreter', 'latex', 'fontsize', 11);

% Window setting
set(gcf, 'renderer', 'painters');
set(gcf, 'units', 'centimeters');
set(gcf, 'position', [0.5, 1.5, 10, 8]);

% Print setting
set(gcf, 'paperunits', 'centimeters');
set(gcf, 'paperpositionmode', 'manual');
set(gcf, 'paperposition', [0, 0, 10, 8]);
set(gcf, 'papertype', '<custom>');
set(gcf, 'papersize', [10, 8]);

% Print to PDF
print('cval_t', '-dpdf');
