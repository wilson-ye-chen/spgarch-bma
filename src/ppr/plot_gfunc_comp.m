%%
% File: plot_gfunc_comp.m
% Purpose:
% This script plots the estimates of coefficient functions of the SPGARCH-t,
% GJR-t, and the Beta-t models. The posterior means are plotted for the S&P
% and Intel data.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   August 21, 2017
%%

% Override the subplot function
subplot = @(m, n, p)subaxis(m, n, p, ...
    'ML', 0.08, ...
    'MB', 0.16, ...
    'MR', 0.02, ...
    'MT', 0.09, ...
    'SH', 0.07);

colorPara = [0, 0, 0];
colorSp = [0.95, 0, 0];
widthPara = 0.8;
widthSp = 1.4;

figure();
subplot(1, 2, 1);
load('gjr_est_spx.mat');
load('spgarch_est_spx.mat');
hold on;
plot(xNif, YNif, '-', 'color', colorPara, 'linewidth', widthPara);
plot(xSpl, YSpl, '--', 'color', colorSp, 'linewidth', widthSp);
axis([-4, 4, 0.5, 3.9]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
xlabel('$\epsilon$', 'interpreter', 'latex', 'fontsize', 13);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', 13);
title('(a) S\&P 500', 'interpreter', 'latex', 'fontsize', 13);
h = legend('GJR', 'SP-GARCH', 'location', 'northeast');
set(h, 'interpreter', 'latex', 'fontsize', 11);

subplot(1, 2, 2);
load('gas_est_intc.mat');
load('spgarch_est_intc.mat');
hold on;
plot(xNif, YNif, '-', 'color', colorPara, 'linewidth', widthPara);
plot(xSpl, YSpl, '--', 'color', colorSp, 'linewidth', widthSp);
axis([-4, 4, 0.85, 1.55]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
xlabel('$\epsilon$', 'interpreter', 'latex', 'fontsize', 13);
title('(b) Intel', 'interpreter', 'latex', 'fontsize', 13);
h = legend('Beta-t', 'SP-GARCH', 'location', 'northeast');
set(h, 'interpreter', 'latex', 'fontsize', 11);

% Window setting
set(gcf, 'renderer', 'painters');
set(gcf, 'units', 'centimeters');
set(gcf, 'position', [0.5, 1.5, 19, 9]);

% Print setting
set(gcf, 'paperunits', 'centimeters');
set(gcf, 'paperpositionmode', 'manual');
set(gcf, 'paperposition', [0, 0, 19, 9]);
set(gcf, 'papertype', '<custom>');
set(gcf, 'papersize', [19, 9]);

% Print to PDF
print('gfunc_comp', '-dpdf');
