% File: table_loss_sim_in.m
% Generate the table of in-sample loss function values form the simulation
% study.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   August 16, 2017

% Load data for generating the table.
load('garch_dgp1.mat');
Sig_garch_g1 = Sig(:, 1:(end - 1))';
load('garch_dgp2.mat');
Sig_garch_g2 = Sig(:, 1:(end - 1))';
load('garch_dgp3.mat');
Sig_garch_g3 = Sig(:, 1:(end - 1))';
load('garch_dgp4.mat');
Sig_garch_g4 = Sig(:, 1:(end - 1))';
load('gjr_dgp1.mat');
Sig_gjr_g1 = Sig(:, 1:(end - 1))';
load('gjr_dgp2.mat');
Sig_gjr_g2 = Sig(:, 1:(end - 1))';
load('gjr_dgp3.mat');
Sig_gjr_g3 = Sig(:, 1:(end - 1))';
load('gjr_dgp4.mat');
Sig_gjr_g4 = Sig(:, 1:(end - 1))';
load('gas_dgp1.mat');
Sig_gas_g1 = Sig(:, 1:(end - 1))';
load('gas_dgp2.mat');
Sig_gas_g2 = Sig(:, 1:(end - 1))';
load('gas_dgp3.mat');
Sig_gas_g3 = Sig(:, 1:(end - 1))';
load('gas_dgp4.mat');
Sig_gas_g4 = Sig(:, 1:(end - 1))';
load('spgarch_dgp1.mat');
Sig_sp_g1 = Sig(:, 1:(end - 1))';
load('spgarch_dgp2.mat');
Sig_sp_g2 = Sig(:, 1:(end - 1))';
load('spgarch_dgp3.mat');
Sig_sp_g3 = Sig(:, 1:(end - 1))';
load('spgarch_dgp4.mat');
Sig_sp_g4 = Sig(:, 1:(end - 1))';
load('data_dgp1.mat');
Sig_true_g1 = Sigma(1:(end - 1), :);
load('data_dgp2.mat');
Sig_true_g2 = Sigma(1:(end - 1), :);
load('data_dgp3.mat');
Sig_true_g3 = Sigma(1:(end - 1), :);
load('data_dgp4.mat');
Sig_true_g4 = Sigma(1:(end - 1), :);

% GARCH
rmse_garch_g1 = mean(rmse(Sig_garch_g1, Sig_true_g1));
mad_garch_g1  = mean(mad(Sig_garch_g1, Sig_true_g1));
rmse_garch_g2 = mean(rmse(Sig_garch_g2, Sig_true_g2));
mad_garch_g2  = mean(mad(Sig_garch_g2, Sig_true_g2));
rmse_garch_g3 = mean(rmse(Sig_garch_g3, Sig_true_g3));
mad_garch_g3  = mean(mad(Sig_garch_g3, Sig_true_g3));
rmse_garch_g4 = mean(rmse(Sig_garch_g4, Sig_true_g4));
mad_garch_g4  = mean(mad(Sig_garch_g4, Sig_true_g4));

% GJR
rmse_gjr_g1 = mean(rmse(Sig_gjr_g1, Sig_true_g1));
mad_gjr_g1  = mean(mad(Sig_gjr_g1, Sig_true_g1));
rmse_gjr_g2 = mean(rmse(Sig_gjr_g2, Sig_true_g2));
mad_gjr_g2  = mean(mad(Sig_gjr_g2, Sig_true_g2));
rmse_gjr_g3 = mean(rmse(Sig_gjr_g3, Sig_true_g3));
mad_gjr_g3  = mean(mad(Sig_gjr_g3, Sig_true_g3));
rmse_gjr_g4 = mean(rmse(Sig_gjr_g4, Sig_true_g4));
mad_gjr_g4  = mean(mad(Sig_gjr_g4, Sig_true_g4));

% Beta-t-GARCH
rmse_gas_g1 = mean(rmse(Sig_gas_g1, Sig_true_g1));
mad_gas_g1  = mean(mad(Sig_gas_g1, Sig_true_g1));
rmse_gas_g2 = mean(rmse(Sig_gas_g2, Sig_true_g2));
mad_gas_g2  = mean(mad(Sig_gas_g2, Sig_true_g2));
rmse_gas_g3 = mean(rmse(Sig_gas_g3, Sig_true_g3));
mad_gas_g3  = mean(mad(Sig_gas_g3, Sig_true_g3));
rmse_gas_g4 = mean(rmse(Sig_gas_g4, Sig_true_g4));
mad_gas_g4  = mean(mad(Sig_gas_g4, Sig_true_g4));

% SPGARCH
rmse_sp_g1 = mean(rmse(Sig_sp_g1, Sig_true_g1));
mad_sp_g1  = mean(mad(Sig_sp_g1, Sig_true_g1));
rmse_sp_g2 = mean(rmse(Sig_sp_g2, Sig_true_g2));
mad_sp_g2  = mean(mad(Sig_sp_g2, Sig_true_g2));
rmse_sp_g3 = mean(rmse(Sig_sp_g3, Sig_true_g3));
mad_sp_g3  = mean(mad(Sig_sp_g3, Sig_true_g3));
rmse_sp_g4 = mean(rmse(Sig_sp_g4, Sig_true_g4));
mad_sp_g4  = mean(mad(Sig_sp_g4, Sig_true_g4));

% Table
Loss12 = [ ...
    rmse_garch_g1, mad_garch_g1, rmse_garch_g2, mad_garch_g2; ...
    rmse_gjr_g1, mad_gjr_g1, rmse_gjr_g2, mad_gjr_g2; ...
    rmse_gas_g1, mad_gas_g1, rmse_gas_g2, mad_gas_g2; ...
    rmse_sp_g1, mad_sp_g1, rmse_sp_g2, mad_sp_g2; ...
    ];
Loss34 = [ ...
    rmse_garch_g3, mad_garch_g3, rmse_garch_g4, mad_garch_g4; ...
    rmse_gjr_g3, mad_gjr_g3, rmse_gjr_g4, mad_gjr_g4; ...
    rmse_gas_g3, mad_gas_g3, rmse_gas_g4, mad_gas_g4; ...
    rmse_sp_g3, mad_sp_g3, rmse_sp_g4, mad_sp_g4; ...
    ];
Loss = [Loss12, Loss34];
disp(Loss);
