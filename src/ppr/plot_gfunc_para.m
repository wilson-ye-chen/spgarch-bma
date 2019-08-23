%%
% File: plot_gfunc_para.m
% Purpose:
% This script plots example coefficient functions of some of the popular
% parametric GARCH models.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   August 21, 2017
%%

% Override the subplot function
subplot = @(m, n, p)subaxis(m, n, p, ...
    'ML', 0.08, ...
    'MB', 0.09, ...
    'MR', 0.02, ...
    'MT', 0.05, ...
    'SH', 0.07, ...
    'SV', 0.09);

ftSz   = 14;
ftSzLg = 12;
lnWd   = 1.2;

% Domain
x = [-4:0.01:4];

% GARCH
g = @(x, b, a)b + (a .* (x .^ 2));
figure();
subplot(2, 2, 1);
hold on;
plot(x, g(x, 0.8, 0.1), '-k', 'LineWidth', lnWd);
plot(x, g(x, 0.8, 0.15), '--k', 'LineWidth', lnWd);
axis([-4, 4, 0.6, 3.5]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', ftSz);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', ftSz);
title('(a) GARCH', 'interpreter', 'latex', 'fontsize', ftSz);
h = legend( ...
    '\thickmuskip=0mu $\beta=0.8, \alpha=0.1$', ...
    '\thickmuskip=0mu $\beta=0.8, \alpha=0.15$', ...
    'location', 'north');
set(h, 'interpreter', 'latex', 'fontsize', ftSzLg);

% GJR
g = @(x, b, a1, a2)b + ((a1 + a2 .* double(x < 0)) .* (x .^ 2));
subplot(2, 2, 2);
hold on;
plot(x, g(x, 0.8, 0.1, 0), '-k', 'LineWidth', lnWd);
plot(x, g(x, 0.8, 0.05, 0.1), '--k', 'LineWidth', lnWd);
axis([-4, 4, 0.6, 3.5]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', ftSz);
title('(b) GJR-GARCH', 'interpreter', 'latex', 'fontsize', ftSz);
h = legend( ...
    '\thickmuskip=0mu $\beta=0.8, \alpha_1=0.1, \alpha_2=0$', ...
    '\thickmuskip=0mu $\beta=0.8, \alpha_1=0.05, \alpha_2=0.1$', ...
    'location', 'north');
set(h, 'interpreter', 'latex', 'fontsize', ftSzLg);

% NAGARCH
g = @(x, b, a, c)b + a .* (x - c) .^ 2;
subplot(2, 2, 3);
hold on;
plot(x, g(x, 0.8, 0.1, 0), '-k', 'LineWidth', lnWd);
plot(x, g(x, 0.8, 0.1, 0.8), '--k', 'LineWidth', lnWd);
axis([-4, 4, 0.6, 3.5]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', ftSz);
xlabel('$\epsilon$', 'interpreter', 'latex', 'fontsize', ftSz);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', ftSz);
title('(c) NAGARCH', 'interpreter', 'latex', 'fontsize', ftSz);
h = legend( ...
    '\thickmuskip=0mu $\beta=0.8, \alpha=0.1, c=0$', ...
    '\thickmuskip=0mu $\beta=0.8, \alpha=0.05, c=0.8$', ...
    'location', 'north');
set(h, 'interpreter', 'latex', 'fontsize', ftSzLg);

% Beta-t-GARCH
u = @(x, nu)(nu + 1) .* (x .^ 2) ./ (nu - 2 + (x .^ 2));
g = @(x, nu, b, a1, a2)b + ((a1 + a2 .* double(x < 0)) .* u(x, nu));
subplot(2, 2, 4);
hold on;
plot(x, g(x, 5, 0.8, 0.1, 0), '-k', 'LineWidth', lnWd);
plot(x, g(x, 5, 0.8, 0.05, 0.1), '--k', 'LineWidth', lnWd);
axis([-4, 4, 0.75, 1.6]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', ftSz);
xlabel('$\epsilon$', 'interpreter', 'latex', 'fontsize', ftSz);
title('(d) Beta-t-GARCH', 'interpreter', 'latex', 'fontsize', ftSz);
h = legend( ...
    '\thickmuskip=0mu $\nu=5, \beta=0.8, \alpha_1=0.1, \alpha_2=0$', ...
    '\thickmuskip=0mu $\nu=5, \beta=0.8, \alpha_1=0.05, \alpha_2=0.1$', ...
    'location', 'northeast');
set(h, 'interpreter', 'latex', 'fontsize', ftSzLg);

% Window setting
set(gcf, 'renderer', 'painters');
set(gcf, 'units', 'centimeters');
set(gcf, 'position', [0.5, 1.5, 21, 19]);

% Print setting
set(gcf, 'paperunits', 'centimeters');
set(gcf, 'paperpositionmode', 'manual');
set(gcf, 'paperposition', [0, 0, 21, 19]);
set(gcf, 'papertype', '<custom>');
set(gcf, 'papersize', [21, 19]);

% Print to PDF
print('gfunc_para', '-dpdf');
