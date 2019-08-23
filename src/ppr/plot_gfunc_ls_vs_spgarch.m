%%
% File: plot_gfunc_ls_vs_spgarch.m
% Purpose:
% This script plots the estimates of coefficient functions of the SPGARCH-t
% and a least-square based estimation procedure. The point-wise posterior
% summaries are plotted for the simulated DGP 2 data, where the true model
% is GARCH(1,1).
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   January 22, 2019
%%

colorTv = [0, 0, 0];
colorPm = [0.95, 0, 0];
colorCi = [1, 0.88, 0.88];

% Spline coefficients of the true function
coef = [0.85, 0, 0.1];

% LS
figure();
subplot(1, 2, 1);
load('ls_dgp2.mat');
hold on;
set(gca, 'layer', 'top');
area(t, quantile(G, 0.975, 2), 'FaceColor', colorCi, 'EdgeColor', 'none');
area(t, quantile(G, 0.025, 2), 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(t, quadspline(t, coef, []), '-k', 'LineWidth', 0.8);
plot(t, quantile(G, 0.5, 2), '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-3, 3, -2, 33]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
xlabel('$\epsilon$', 'interpreter', 'latex', 'fontsize', 13);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', 13);
title('(a) Suggested Method', 'fontsize', 10);
box on;

% SP-GARCH
subplot(1, 2, 2);
load('spgarch_dgp2.mat');
hold on;
set(gca, 'layer', 'top');
area(x, quantile(Y, 0.975, 1), 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, quantile(Y, 0.025, 1), 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, quadspline(x, coef, []), '-k', 'LineWidth', 0.8);
plot(x, quantile(Y, 0.5, 1), '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-3, 3, 0.65, 2.2]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
xlabel('$\epsilon$', 'interpreter', 'latex', 'fontsize', 13);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', 13);
title('(b) SP-GARCH', 'fontsize', 10);
box on;

% Window setting
set(gcf, 'renderer', 'opengl');
set(gcf, 'units', 'centimeters');
set(gcf, 'position', [0.5, 1.5, 20, 10]);

% Print setting
set(gcf, 'paperunits', 'centimeters');
set(gcf, 'paperpositionmode', 'manual');
set(gcf, 'paperposition', [0, 0, 20, 10]);
set(gcf, 'papertype', '<custom>');
set(gcf, 'papersize', [20, 10]);

% Print to PNG
print('gfunc_ls_vs_spgarch', '-r600', '-dpng');
