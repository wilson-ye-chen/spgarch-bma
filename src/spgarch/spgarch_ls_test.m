%%
% File: spgarch_ls_test.m
% Purpose:
% This script runs a least-square based estimation procedure for
% the SPGARCH model on a simulated dataset.
%
% Date: January 3, 2019
%%

% Add CPLEX path
addpath('/opt/ibm/ILOG/CPLEX_Studio1271/cplex/matlab/x86-64_linux');

% Load simulated dataset where the true model is GARCH(1,1)
load('data_dgp2.mat');

% Knot vector
k = tinv((0.1:0.1:0.9), 8) .* sqrt((8 - 2) ./ 8);

% Fit the model to each simulated series
nObs = size(R, 1);
nRep = size(R, 2);
G = zeros(500, nRep);
Coef = zeros(13, nRep);
YyHat = zeros(nObs, nRep);
for i = 1:nRep
    [G(:, i), t, B, YyHat(:, i)] = spgarch_ls(R(:, i), k, 30);
    Coef(:, i) = B(:, end);
    disp(['i = ', num2str(i)]);
end

% Save results
save('ls_dgp2.mat', 'G', 't', 'Coef', 'YyHat');

% Plot coefficient function
figure();
hold on;
plot(t, quantile(G, 0.5, 2), '-k', 'linewidth', 1);
plot(t, quantile(G, 0.025, 2), '--r', 'linewidth', 1);
plot(t, quantile(G, 0.975, 2), '--r', 'linewidth', 1);
axis([-3, 3, -2, 35]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
xlabel('$\epsilon$', 'interpreter', 'latex', 'fontsize', 13);
ylabel('$g(\epsilon)$', 'interpreter', 'latex', 'fontsize', 13);

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
print('gfunc_ls', '-dpdf');
