% File: table_loss_sim_out.m
% Generate the table of out-of-sample loss function values form the
% simulation study.
%
% Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
% Date:   August 16, 2017

% Load data for generating the table.
load('garch_dgp1.mat');
sig_garch_g1 = Sig(:, end);
load('garch_dgp2.mat');
sig_garch_g2 = Sig(:, end);
load('garch_dgp3.mat');
sig_garch_g3 = Sig(:, end);
load('garch_dgp4.mat');
sig_garch_g4 = Sig(:, end);
load('gjr_dgp1.mat');
sig_gjr_g1 = Sig(:, end);
load('gjr_dgp2.mat');
sig_gjr_g2 = Sig(:, end);
load('gjr_dgp3.mat');
sig_gjr_g3 = Sig(:, end);
load('gjr_dgp4.mat');
sig_gjr_g4 = Sig(:, end);
load('gas_dgp1.mat');
sig_gas_g1 = Sig(:, end);
load('gas_dgp2.mat');
sig_gas_g2 = Sig(:, end);
load('gas_dgp3.mat');
sig_gas_g3 = Sig(:, end);
load('gas_dgp4.mat');
sig_gas_g4 = Sig(:, end);
load('spgarch_dgp1.mat');
sig_sp_g1 = Sig(:, end);
load('spgarch_dgp2.mat');
sig_sp_g2 = Sig(:, end);
load('spgarch_dgp3.mat');
sig_sp_g3 = Sig(:, end);
load('spgarch_dgp4.mat');
sig_sp_g4 = Sig(:, end);
load('data_dgp1.mat');
sig_true_g1 = Sigma(end, :)';
load('data_dgp2.mat');
sig_true_g2 = Sigma(end, :)';
load('data_dgp3.mat');
sig_true_g3 = Sigma(end, :)';
load('data_dgp4.mat');
sig_true_g4 = Sigma(end, :)';

% GARCH
rmse_garch_g1 = rmse(sig_garch_g1, sig_true_g1);
mad_garch_g1  = mad(sig_garch_g1, sig_true_g1);
rmse_garch_g2 = rmse(sig_garch_g2, sig_true_g2);
mad_garch_g2  = mad(sig_garch_g2, sig_true_g2);
rmse_garch_g3 = rmse(sig_garch_g3, sig_true_g3);
mad_garch_g3  = mad(sig_garch_g3, sig_true_g3);
rmse_garch_g4 = rmse(sig_garch_g4, sig_true_g4);
mad_garch_g4  = mad(sig_garch_g4, sig_true_g4);

% GJR
rmse_gjr_g1 = rmse(sig_gjr_g1, sig_true_g1);
mad_gjr_g1  = mad(sig_gjr_g1, sig_true_g1);
rmse_gjr_g2 = rmse(sig_gjr_g2, sig_true_g2);
mad_gjr_g2  = mad(sig_gjr_g2, sig_true_g2);
rmse_gjr_g3 = rmse(sig_gjr_g3, sig_true_g3);
mad_gjr_g3  = mad(sig_gjr_g3, sig_true_g3);
rmse_gjr_g4 = rmse(sig_gjr_g4, sig_true_g4);
mad_gjr_g4  = mad(sig_gjr_g4, sig_true_g4);

% Beta-t-GARCH
rmse_gas_g1 = rmse(sig_gas_g1, sig_true_g1);
mad_gas_g1  = mad(sig_gas_g1, sig_true_g1);
rmse_gas_g2 = rmse(sig_gas_g2, sig_true_g2);
mad_gas_g2  = mad(sig_gas_g2, sig_true_g2);
rmse_gas_g3 = rmse(sig_gas_g3, sig_true_g3);
mad_gas_g3  = mad(sig_gas_g3, sig_true_g3);
rmse_gas_g4 = rmse(sig_gas_g4, sig_true_g4);
mad_gas_g4  = mad(sig_gas_g4, sig_true_g4);

% SPGARCH
rmse_sp_g1 = rmse(sig_sp_g1, sig_true_g1);
mad_sp_g1  = mad(sig_sp_g1, sig_true_g1);
rmse_sp_g2 = rmse(sig_sp_g2, sig_true_g2);
mad_sp_g2  = mad(sig_sp_g2, sig_true_g2);
rmse_sp_g3 = rmse(sig_sp_g3, sig_true_g3);
mad_sp_g3  = mad(sig_sp_g3, sig_true_g3);
rmse_sp_g4 = rmse(sig_sp_g4, sig_true_g4);
mad_sp_g4  = mad(sig_sp_g4, sig_true_g4);

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
