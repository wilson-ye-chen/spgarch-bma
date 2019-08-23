%%
% File: plot_chain_theta.m
% Purpose:
% This script plots the sample paths and scatter plot of b_2 and beta_3
% for AAPL.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   June 26, 2016
%%

% Override the subplot function
subplot = @(m, n, p)subaxis(m, n, p, ...
    'ML', 0.09, ...
    'MB', 0.14, ...
    'MR', 0.01, ...
    'MT', 0.09, ...
    'SH', 0.09, ...
    'SV', 0.16);

colorDot = [1, 0.3, 0.3];

% Load MCMC output for AAPL
load('spgarch_est_aapl.mat');

figure();
subplot(2, 10, 1:6);
plot(Chain(:, 6), '.', 'color', colorDot);
axis([1, 500000, -0.06, 0.03]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
ylabel('$b_{2}$', 'interpreter', 'latex', 'fontsize', 13);
title('(a)', 'interpreter', 'latex', 'fontsize', 13);

subplot(2, 10, 11:16);
plot(Chain(:, 9), '.', 'color', colorDot);
axis([1, 500000, -1, 1.2]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
xlabel('Iteration', 'interpreter', 'latex', 'fontsize', 13);
ylabel('$\beta_{3}$', 'interpreter', 'latex', 'fontsize', 13);
title('(b)', 'interpreter', 'latex', 'fontsize', 13);

subplot(2, 10, [7:10, 17:20]);
plot(Chain(:, 6), Chain(:, 9), '.', 'color', colorDot);
axis([-0.06, 0.03, -1, 1.2]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
xlabel('$b_{2}$', 'interpreter', 'latex', 'fontsize', 13);
ylabel('$\beta_{3}$', 'interpreter', 'latex', 'fontsize', 13);
title('(c)', 'interpreter', 'latex', 'fontsize', 13);

% Window setting
set(gcf, 'renderer', 'opengl');
set(gcf, 'units', 'centimeters');
set(gcf, 'position', [0.5, 1.5, 21, 9]);

% Print setting
set(gcf, 'paperunits', 'centimeters');
set(gcf, 'paperpositionmode', 'manual');
set(gcf, 'paperposition', [0, 0, 21, 9]);
set(gcf, 'papertype', '<custom>');
set(gcf, 'papersize', [21, 9]);

% Print to PNG
print('chain_theta', '-r600', '-dpng');
