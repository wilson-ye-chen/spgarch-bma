%%
% File: plot_gfunc_emp.m
% Purpose:
% This script plots the estimates of coefficient functions of the SPGARCH-t
% model. The posterior mean and the 95-percent credible interval are plotted
% for each dataset.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   August 21, 2017
%%

% Override the subplot function
subplot = @(m, n, p)subaxis(m, n, p, ...
    'ML', 0.11, ...
    'MB', 0.06, ...
    'MR', 0.03, ...
    'MT', 0.02, ...
    'SH', 0.09, ...
    'SV', 0.04);

colorPm = [0.85, 0, 0];
colorCi = [1, 0.88, 0.88];
widthPm = 1.4;

figure();
subplot(5, 2, 1);
load('spgarch_g_spx.mat');
hold on;
area(x, u, 'facecolor', colorCi, 'edgecolor', 'none');
area(x, l, 'facecolor', [1, 1, 1], 'edgecolor', 'none');
plot(x, m, '-', 'color', colorPm, 'linewidth', widthPm);
axis([-4, 4, 0.65, 3.35]);
set(gca, 'layer', 'top');
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', 13);
text(0, 3.2, '(a) S\&P 500', ...
    'horizontalalignment', 'center', ...
    'verticalalignment', 'cap', ...
    'interpreter', 'latex', ...
    'fontsize', 11);

subplot(5, 2, 3);
load('spgarch_g_ftse.mat');
hold on;
area(x, u, 'facecolor', colorCi, 'edgecolor', 'none');
area(x, l, 'facecolor', [1, 1, 1], 'edgecolor', 'none');
plot(x, m, '-', 'color', colorPm, 'linewidth', widthPm);
axis([-4, 4, 0.65, 3.35]);
set(gca, 'layer', 'top');
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', 13);
text(0, 3.2, '(b) FTSE', ...
    'horizontalalignment', 'center', ...
    'verticalalignment', 'cap', ...
    'interpreter', 'latex', ...
    'fontsize', 11);

subplot(5, 2, 5);
load('spgarch_g_dax.mat');
hold on;
area(x, u, 'facecolor', colorCi, 'edgecolor', 'none');
area(x, l, 'facecolor', [1, 1, 1], 'edgecolor', 'none');
plot(x, m, '-', 'color', colorPm, 'linewidth', widthPm);
axis([-4, 4, 0.65, 3.35]);
set(gca, 'layer', 'top');
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', 13);
text(0, 3.2, '(c) DAX', ...
    'horizontalalignment', 'center', ...
    'verticalalignment', 'cap', ...
    'interpreter', 'latex', ...
    'fontsize', 11);

subplot(5, 2, 7);
load('spgarch_g_n225.mat');
hold on;
area(x, u, 'facecolor', colorCi, 'edgecolor', 'none');
area(x, l, 'facecolor', [1, 1, 1], 'edgecolor', 'none');
plot(x, m, '-', 'color', colorPm, 'linewidth', widthPm);
axis([-4, 4, 0.65, 3.35]);
set(gca, 'layer', 'top');
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', 13);
text(0, 3.2, '(d) Nikkei', ...
    'horizontalalignment', 'center', ...
    'verticalalignment', 'cap', ...
    'interpreter', 'latex', ...
    'fontsize', 11);

subplot(5, 2, 9);
load('spgarch_g_hsi.mat');
hold on;
area(x, u, 'facecolor', colorCi, 'edgecolor', 'none');
area(x, l, 'facecolor', [1, 1, 1], 'edgecolor', 'none');
plot(x, m, '-', 'color', colorPm, 'linewidth', widthPm);
axis([-4, 4, 0.75, 2.7]);
set(gca, 'layer', 'top');
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
xlabel('$\epsilon$', 'interpreter', 'latex', 'fontsize', 13);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', 13);
text(0, 2.58, '(e) Hang Seng', ...
    'horizontalalignment', 'center', ...
    'verticalalignment', 'cap', ...
    'interpreter', 'latex', ...
    'fontsize', 11);

subplot(5, 2, 2);
load('spgarch_g_aapl.mat');
hold on;
area(x, u, 'facecolor', colorCi, 'edgecolor', 'none');
area(x, l, 'facecolor', [1, 1, 1], 'edgecolor', 'none');
plot(x, m, '-', 'color', colorPm, 'linewidth', widthPm);
axis([-4, 4, 0.8, 2]);
set(gca, 'layer', 'top');
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
text(0, 1.93, '(f) Apple', ...
    'horizontalalignment', 'center', ...
    'verticalalignment', 'cap', ...
    'interpreter', 'latex', ...
    'fontsize', 11);

subplot(5, 2, 4);
load('spgarch_g_armh.mat');
hold on;
area(x, u, 'facecolor', colorCi, 'edgecolor', 'none');
area(x, l, 'facecolor', [1, 1, 1], 'edgecolor', 'none');
plot(x, m, '-', 'color', colorPm, 'linewidth', widthPm);
axis([-4, 4, 0.8, 1.7]);
set(gca, 'layer', 'top');
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
text(0, 1.65, '(g) ARM', ...
    'horizontalalignment', 'center', ...
    'verticalalignment', 'cap', ...
    'interpreter', 'latex', ...
    'fontsize', 11);

subplot(5, 2, 6);
load('spgarch_g_intc.mat');
hold on;
area(x, u, 'facecolor', colorCi, 'edgecolor', 'none');
area(x, l, 'facecolor', [1, 1, 1], 'edgecolor', 'none');
plot(x, m, '-', 'color', colorPm, 'linewidth', widthPm);
axis([-4, 4, 0.8, 1.7]);
set(gca, 'layer', 'top');
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
text(0, 1.65, '(h) Intel', ...
    'horizontalalignment', 'center', ...
    'verticalalignment', 'cap', ...
    'interpreter', 'latex', ...
    'fontsize', 11);

subplot(5, 2, 8);
load('spgarch_g_nvda.mat');
hold on;
area(x, u, 'facecolor', colorCi, 'edgecolor', 'none');
area(x, l, 'facecolor', [1, 1, 1], 'edgecolor', 'none');
plot(x, m, '-', 'color', colorPm, 'linewidth', widthPm);
axis([-4, 4, 0.8, 1.7]);
set(gca, 'layer', 'top');
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
text(0, 1.65, '(i) Nvidia', ...
    'horizontalalignment', 'center', ...
    'verticalalignment', 'cap', ...
    'interpreter', 'latex', ...
    'fontsize', 11);

subplot(5, 2, 10);
load('spgarch_g_sndk.mat');
hold on;
area(x, u, 'facecolor', colorCi, 'edgecolor', 'none');
area(x, l, 'facecolor', [1, 1, 1], 'edgecolor', 'none');
plot(x, m, '-', 'color', colorPm, 'linewidth', widthPm);
axis([-4, 4, 0.8, 1.7]);
set(gca, 'layer', 'top');
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
xlabel('$\epsilon$', 'interpreter', 'latex', 'fontsize', 13);
text(0, 1.65, '(j) SanDisk', ...
    'horizontalalignment', 'center', ...
    'verticalalignment', 'cap', ...
    'interpreter', 'latex', ...
    'fontsize', 11);

% Window setting
set(gcf, 'renderer', 'painters');
set(gcf, 'units', 'centimeters');
set(gcf, 'position', [0.5, 1.5, 13, 20]);

% Print setting
set(gcf, 'paperunits', 'centimeters');
set(gcf, 'paperpositionmode', 'manual');
set(gcf, 'paperposition', [0, 0, 15, 27]);
set(gcf, 'papertype', '<custom>');
set(gcf, 'papersize', [15, 27]);

% Print to PDF
print('gfunc_emp', '-dpdf');
