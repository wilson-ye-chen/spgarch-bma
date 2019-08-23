%%
% File: plot_gfunc_spgarch_vs_gas.m
% Purpose:
% This script plots the estimates of coefficient functions of the SPGARCH-t
% and the Beta-t models. The posterior means are plotted for the Intel data.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   November 18, 2016
%%

% Override the subplot function
subplot = @(m, n, p)subaxis(m, n, p, ...
    'ML', 0.14, ...
    'MB', 0.16, ...
    'MR', 0.03, ...
    'MT', 0.04);

colorGas = [0, 0, 0];
colorSp = [0.95, 0, 0];
widthGas = 0.8;
widthSp = 1.4;

figure();
subplot(1, 1, 1);
load('gas_est_intc.mat');
load('spgarch_est_intc.mat');
hold on;
plot(xNif, YNif, '-', 'color', colorGas, 'linewidth', widthGas);
plot(xSpl, YSpl, '--', 'color', colorSp, 'linewidth', widthSp);
axis([-4, 4, 0.85, 1.55]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
xlabel('$\epsilon_{t-1}$', 'interpreter', 'latex', 'fontsize', 13);
ylabel('$g(\epsilon_{t-1})$', 'interpreter', 'latex', 'fontsize', 13);
h = legend('Beta-t', 'SP-GARCH', 'location', 'northeast');
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
print('gfunc_spgarch_vs_gas', '-dpdf');
