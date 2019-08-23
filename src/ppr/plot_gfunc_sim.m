%%
% File: plot_gfunc_sim.m
% Script for plotting the NIFs (g functions) from the simulation study.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   August 21, 2017
%%

% Override the subplot function
subplot = @(m, n, p)subaxis(m, n, p, ...
    'ML', 0.06, ...
    'MB', 0.06, ...
    'MR', 0.04, ...
    'MT', 0.04, ...
    'SH', 0.05, ...
    'SV', 0.07);

colorTv = [0, 0, 0];
colorPm = [0.95, 0, 0];
colorCi = [1, 0.88, 0.88];

% Load data required for generating the plots
load('garch_dgp1.mat');
y_garch_g1 = mean(Y, 1);
lb_garch_g1 = quantile(Y, 0.025, 1);
ub_garch_g1 = quantile(Y, 0.975, 1);
load('gjr_dgp1.mat');
y_gjr_g1 = mean(Y, 1);
lb_gjr_g1 = quantile(Y, 0.025, 1);
ub_gjr_g1 = quantile(Y, 0.975, 1);
load('gas_dgp1.mat');
y_gas_g1 = mean(Y, 1);
lb_gas_g1 = quantile(Y, 0.025, 1);
ub_gas_g1 = quantile(Y, 0.975, 1);
load('spgarch_dgp1.mat');
y_sp_g1 = mean(Y, 1);
lb_sp_g1 = quantile(Y, 0.025, 1);
ub_sp_g1 = quantile(Y, 0.975, 1);
load('garch_dgp2.mat');
y_garch_g2 = mean(Y, 1);
lb_garch_g2 = quantile(Y, 0.025, 1);
ub_garch_g2 = quantile(Y, 0.975, 1);
load('gjr_dgp2.mat');
y_gjr_g2 = mean(Y, 1);
lb_gjr_g2 = quantile(Y, 0.025, 1);
ub_gjr_g2 = quantile(Y, 0.975, 1);
load('gas_dgp2.mat');
y_gas_g2 = mean(Y, 1);
lb_gas_g2 = quantile(Y, 0.025, 1);
ub_gas_g2 = quantile(Y, 0.975, 1);
load('spgarch_dgp2.mat');
y_sp_g2 = mean(Y, 1);
lb_sp_g2 = quantile(Y, 0.025, 1);
ub_sp_g2 = quantile(Y, 0.975, 1);
load('garch_dgp3.mat');
y_garch_g3 = mean(Y, 1);
lb_garch_g3 = quantile(Y, 0.025, 1);
ub_garch_g3 = quantile(Y, 0.975, 1);
load('gjr_dgp3.mat');
y_gjr_g3 = mean(Y, 1);
lb_gjr_g3 = quantile(Y, 0.025, 1);
ub_gjr_g3 = quantile(Y, 0.975, 1);
load('gas_dgp3.mat');
y_gas_g3 = mean(Y, 1);
lb_gas_g3 = quantile(Y, 0.025, 1);
ub_gas_g3 = quantile(Y, 0.975, 1);
load('spgarch_dgp3.mat');
y_sp_g3 = mean(Y, 1);
lb_sp_g3 = quantile(Y, 0.025, 1);
ub_sp_g3 = quantile(Y, 0.975, 1);
load('garch_dgp4.mat');
y_garch_g4 = mean(Y, 1);
lb_garch_g4 = quantile(Y, 0.025, 1);
ub_garch_g4 = quantile(Y, 0.975, 1);
load('gjr_dgp4.mat');
y_gjr_g4 = mean(Y, 1);
lb_gjr_g4 = quantile(Y, 0.025, 1);
ub_gjr_g4 = quantile(Y, 0.975, 1);
load('gas_dgp4.mat');
y_gas_g4 = mean(Y, 1);
lb_gas_g4 = quantile(Y, 0.025, 1);
ub_gas_g4 = quantile(Y, 0.975, 1);
load('spgarch_dgp4.mat');
y_sp_g4 = mean(Y, 1);
lb_sp_g4 = quantile(Y, 0.025, 1);
ub_sp_g4 = quantile(Y, 0.975, 1);

% True NIFs
nu = 8;
k_g1 = tinv((0.1:0.1:0.9), nu) .* sqrt((nu - 2) ./ nu);
k_g2 = [];
k_g4 = [0];
spCoef_g1 = [1.1, 0, 0, 0, -0.48, 0.58, 0, 0, 0, 0, 0, 0];
spCoef_g2 = [0.85, 0, 0.1];
spCoef_g4 = [0.8, 0, 0.25, -0.15];
theta_g3 = [5, 0, 0.1, 0.15, 0, 0.82];

% Arguments of the NIFs
x = -4:0.01:4;

% New figure
figure();

% (a) GARCH - g1
subplot(4, 4, 1);
hold on;
set(gca, 'layer', 'top');
area(x, ub_garch_g1, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_garch_g1, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, quadspline(x, spCoef_g1, k_g1), '-k', 'LineWidth', 0.8);
plot(x, y_garch_g1, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.7, 2.5]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', 13);
title('(a) GARCH $\vert$ DGP 1', 'interpreter', 'latex', 'fontsize', 13);

% (b) GJR - g1
subplot(4, 4, 2);
hold on;
set(gca, 'layer', 'top');
area(x, ub_gjr_g1, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_gjr_g1, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, quadspline(x, spCoef_g1, k_g1), '-k', 'LineWidth', 0.8);
plot(x, y_gjr_g1, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.7, 2.5]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
title('(b) GJR $\vert$ DGP 1', 'interpreter', 'latex', 'fontsize', 13);

% (c) Beta-t-GARCH - g1
subplot(4, 4, 3);
hold on;
set(gca, 'layer', 'top');
area(x, ub_gas_g1, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_gas_g1, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, quadspline(x, spCoef_g1, k_g1), '-k', 'LineWidth', 0.8);
plot(x, y_gas_g1, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.7, 2.5]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
title('(c) Beta-t $\vert$ DGP 1', 'interpreter', 'latex', 'fontsize', 13);

% (d) SPGARCH - g1
subplot(4, 4, 4);
hold on;
set(gca, 'layer', 'top');
area(x, ub_sp_g1, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_sp_g1, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, quadspline(x, spCoef_g1, k_g1), '-k', 'LineWidth', 0.8);
plot(x, y_sp_g1, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.7, 2.5]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
title('(d) SP-GARCH $\vert$ DGP 1', 'interpreter', 'latex', 'fontsize', 13);

% (e) GARCH - g2
subplot(4, 4, 5);
hold on;
set(gca, 'layer', 'top');
area(x, ub_garch_g2, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_garch_g2, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, quadspline(x, spCoef_g2, k_g2), '-k', 'LineWidth', 0.8);
plot(x, y_garch_g2, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.65, 2.9]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', 13);
title('(e) GARCH $\vert$ DGP 2', 'interpreter', 'latex', 'fontsize', 13);

% (f) GJR - g2
subplot(4, 4, 6);
hold on;
set(gca, 'layer', 'top');
area(x, ub_gjr_g2, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_gjr_g2, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, quadspline(x, spCoef_g2, k_g2), '-k', 'LineWidth', 0.8);
plot(x, y_gjr_g2, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.65, 2.9]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
title('(f) GJR $\vert$ DGP 2', 'interpreter', 'latex', 'fontsize', 13);

% (g) Beta-t-GARCH - g2
subplot(4, 4, 7);
hold on;
set(gca, 'layer', 'top');
area(x, ub_gas_g2, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_gas_g2, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, quadspline(x, spCoef_g2, k_g2), '-k', 'LineWidth', 0.8);
plot(x, y_gas_g2, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.65, 2.9]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
title('(g) Beta-t $\vert$ DGP 2', 'interpreter', 'latex', 'fontsize', 13);

% (h) SPGARCH - g2
subplot(4, 4, 8);
hold on;
set(gca, 'layer', 'top');
area(x, ub_sp_g2, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_sp_g2, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, quadspline(x, spCoef_g2, k_g2), '-k', 'LineWidth', 0.8);
plot(x, y_sp_g2, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.65, 2.9]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
title('(h) SP-GARCH $\vert$ DGP 2', 'interpreter', 'latex', 'fontsize', 13);

% (i) GARCH - g3
subplot(4, 4, 9);
hold on;
set(gca, 'layer', 'top');
area(x, ub_garch_g3, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_garch_g3, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, gas_avenif_t(x, theta_g3), '-k', 'LineWidth', 0.8);
plot(x, y_garch_g3, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.65, 3.2]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', 13);
title('(i) GARCH $\vert$ DGP 3', 'interpreter', 'latex', 'fontsize', 13);

% (j) GJR - g3
subplot(4, 4, 10);
hold on;
set(gca, 'layer', 'top');
area(x, ub_gjr_g3, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_gjr_g3, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, gas_avenif_t(x, theta_g3), '-k', 'LineWidth', 0.8);
plot(x, y_gjr_g3, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.65, 3.2]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
title('(j) GJR $\vert$ DGP 3', 'interpreter', 'latex', 'fontsize', 13);

% (k) Beta-t-GARCH - g3
subplot(4, 4, 11);
hold on;
set(gca, 'layer', 'top');
area(x, ub_gas_g3, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_gas_g3, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, gas_avenif_t(x, theta_g3), '-k', 'LineWidth', 0.8);
plot(x, y_gas_g3, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.65, 3.2]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
title('(k) Beta-t $\vert$ DGP 3', 'interpreter', 'latex', 'fontsize', 13);

% (l) SPGARCH - g3
subplot(4, 4, 12);
hold on;
set(gca, 'layer', 'top');
area(x, ub_sp_g3, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_sp_g3, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, gas_avenif_t(x, theta_g3), '-k', 'LineWidth', 0.8);
plot(x, y_sp_g3, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.65, 3.2]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
title('(l) SP-GARCH $\vert$ DGP 3', 'interpreter', 'latex', 'fontsize', 13);

% (m) GARCH - g4
subplot(4, 4, 13);
hold on;
set(gca, 'layer', 'top');
area(x, ub_garch_g4, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_garch_g4, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, quadspline(x, spCoef_g4, k_g4), '-k', 'LineWidth', 0.8);
plot(x, y_garch_g4, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.45, 5.5]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
xlabel('$\epsilon$', 'interpreter', 'latex', 'fontsize', 13);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', 13);
title('(m) GARCH $\vert$ DGP 4', 'interpreter', 'latex', 'fontsize', 13);

% (n) GJR - g4
subplot(4, 4, 14);
hold on;
set(gca, 'layer', 'top');
area(x, ub_gjr_g4, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_gjr_g4, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, quadspline(x, spCoef_g4, k_g4), '-k', 'LineWidth', 0.8);
plot(x, y_gjr_g4, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.45, 5.5]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
xlabel('$\epsilon$', 'interpreter', 'latex', 'fontsize', 13);
title('(n) GJR $\vert$ DGP 4', 'interpreter', 'latex', 'fontsize', 13);

% (o) Beta-t-GARCH - g4
subplot(4, 4, 15);
hold on;
set(gca, 'layer', 'top');
area(x, ub_gas_g4, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_gas_g4, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, quadspline(x, spCoef_g4, k_g4), '-k', 'LineWidth', 0.8);
plot(x, y_gas_g4, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.45, 5.5]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
xlabel('$\epsilon$', 'interpreter', 'latex', 'fontsize', 13);
title('(o) Beta-t $\vert$ DGP 4', 'interpreter', 'latex', 'fontsize', 13);

% (p) SPGARCH - g4
subplot(4, 4, 16);
hold on;
set(gca, 'layer', 'top');
area(x, ub_sp_g4, 'FaceColor', colorCi, 'EdgeColor', 'none');
area(x, lb_sp_g4, 'FaceColor', [1, 1, 1], 'EdgeColor', 'none');
plot(x, quadspline(x, spCoef_g4, k_g4), '-k', 'LineWidth', 0.8);
plot(x, y_sp_g4, '--', 'color', colorPm, 'LineWidth', 1.4);
hold off;
axis([-4, 4, 0.45, 5.5]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
xlabel('$\epsilon$', 'interpreter', 'latex', 'fontsize', 13);
title('(p) SP-GARCH $\vert$ DGP 4', 'interpreter', 'latex', 'fontsize', 13);

% Window setting
set(gcf, 'renderer', 'painters');
set(gcf, 'units', 'centimeters');
set(gcf, 'position', [0.5, 1.5, 25, 25]);

% Print setting
set(gcf, 'paperunits', 'centimeters');
set(gcf, 'paperpositionmode', 'manual');
set(gcf, 'paperposition', [0, 0, 25, 25]);
set(gcf, 'papertype', '<custom>');
set(gcf, 'papersize', [25, 25]);

% Print to PDF
print('gfunc_sim', '-dpdf');
