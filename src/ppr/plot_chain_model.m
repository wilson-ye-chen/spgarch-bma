%%
% File: plot_chain_model.m
% Purpose:
% This script plots the sample paths in the model space for SPX and AAPL.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   June 23, 2016
%%

% Override the subplot function
subplot = @(m, n, p)subaxis(m, n, p, ...
    'ML', 0.07, ...
    'MB', 0.14, ...
    'MR', 0.01, ...
    'MT', 0.09, ...
    'SH', 0.06);

colorDot = [1, 0.3, 0.3];

figure();
subplot(1, 2, 1);
load('spgarch_est_spx.mat');
M = Model(:, 7:end);
tau = bi2de(M, 'left-msb');
plot(tau, '.', 'color', colorDot);
axis([1, 500000, 0, 450]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
xlabel('Iteration', 'interpreter', 'latex', 'fontsize', 13);
ylabel('$\tau$', 'interpreter', 'latex', 'fontsize', 13);
title('(a) S\&P 500', 'interpreter', 'latex', 'fontsize', 13);

subplot(1, 2, 2);
load('spgarch_est_aapl.mat');
M = Model(:, 7:end);
tau = bi2de(M, 'left-msb');
plot(tau, '.', 'color', colorDot);
axis([1, 500000, 0, 450]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 13);
xlabel('Iteration', 'interpreter', 'latex', 'fontsize', 13);
title('(b) Apple', 'interpreter', 'latex', 'fontsize', 13);

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
print('chain_model', '-r600', '-dpng');
