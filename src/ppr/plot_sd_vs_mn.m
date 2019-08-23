%%
% File: plot_sd_vs_mn.m
% Purpose:
% This script creates the scatter-plot of the posterior means of the
% unconditional means against the unconditional standard deviations.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   July 12, 2016
%%

% Override the subplot function
subplot = @(m, n, p)subaxis(m, n, p, ...
    'ML', 0.12, ...
    'MB', 0.12, ...
    'MR', 0.02, ...
    'MT', 0.02);

% Texts
txt{1} = 'S\&P 500';
txt{2} = 'FTSE';
txt{3} = 'DAX';
txt{4} = 'Nikkei';
txt{5} = 'Hang Seng';
txt{6} = 'Apple';
txt{7} = 'ARM';
txt{8} = 'Intel';
txt{9} = 'Nvidia';
txt{10} = 'SanDisk';

% Text vertical alignment
vAlign{1} = 'cap';
vAlign{2} = 'cap';
vAlign{3} = 'baseline';
vAlign{4} = 'baseline';
vAlign{5} = 'baseline';
vAlign{6} = 'baseline';
vAlign{7} = 'baseline';
vAlign{8} = 'baseline';
vAlign{9} = 'baseline';
vAlign{10} = 'baseline';

colorId = [0.85, 0, 0];
colorSt = [0.85, 0, 0];

load('spgarch_uncmnsd.mat');

% Scatter-plot
figure();
subplot(1, 1, 1);
hold on;
plot(mSd(1:5), mMu(1:5), '.', 'color', colorId, 'markersize', 11);
plot(mSd(6:10), mMu(6:10), '.', 'color', colorSt, 'markersize', 11);
axis([1, 9, 0, 0.13]);
set(gca, 'ticklabelinterpreter', 'latex', 'fontsize', 11);
xlabel('$\sigma$', 'interpreter', 'latex', 'fontsize', 13);
ylabel('$\mu$', 'interpreter', 'latex', 'fontsize', 13);

% Text labels
for i = 1:10
    text(mSd(i) + 0.1, mMu(i), txt(i), ...
        'horizontalalignment', 'left', ...
        'verticalalignment', vAlign{i}, ...
        'interpreter', 'latex', ...
        'fontsize', 10);
end

% Window setting
set(gcf, 'renderer', 'painters');
set(gcf, 'units', 'centimeters');
set(gcf, 'position', [0.5, 1.5, 12, 10]);

% Print setting
set(gcf, 'paperunits', 'centimeters');
set(gcf, 'paperpositionmode', 'manual');
set(gcf, 'paperposition', [0, 0, 12, 10]);
set(gcf, 'papertype', '<custom>');
set(gcf, 'papersize', [12, 10]);

% Print to PDF
print('sd_vs_mn', '-dpdf');
