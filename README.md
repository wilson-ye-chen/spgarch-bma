# spgarch-bma
Code for 'Semiparametric GARCH via Bayesian Model Averaging'
[arXiv](https://arxiv.org/abs/1708.07587).

# Data
## Description
The dataset used in the empirical studies of the paper contains observations of end-of-day (EOD) percentage log-returns for stock indices and individual stocks: S&P 500 (SPX), FTSE 100 (FTSE), DAX, Nikkei Stock Average 225 (Nikkei), Hang Seng (HSI), Apple (AAPL), ARM (ARMH), Intel (INTC), Nvidia (NVDA), and SanDisk (SNDK).

Links to data:
* MATLAB binary files (MAT) return series: [Here](https://github.com/wilson-ye-chen/spgarch-bma/tree/master/src/spgarch).

The EOD return series for a single asset is stored in `data_<code>.mat`, where `<code>` is the abbreviated code of the asset. Each file contains the following variables:
* `D` - date vectors.
* `r` - returns.

Note: all the MAT files can be directly loaded into MATLAB by calling the `load` function, e.g., `load('data_aapl.mat')`.

# Source code
## Description
All the source code files are under the `src` directory. The sub-directories under `src` are organised as follows:
* `garch` - functions associated with the parametric GARCH models.
* `spgarch` - functions associated with the SP-GARCH model, as well as real and simulated datasets.
* `ppr` - high-level functions and saved results for producing 'paper specific' results. Some functions require intermediate results returned by the lower-level functions in `garch` and `spgarch`.
* `sh` - BASH shell scripts for automatically submitting estimation/forecasting jobs to be executed in parallel on an Unix/Linux cluster (via PBS job scripts).
* `subaxis` - code written by Aslak Grinsted for generating more flexible sub-plots.

## Access to HPC
Access to an Unix/Linux cluster supporting PBS scripts and MATLAB is desirable as it enables the forecasts and estimation results to be generated in parallel (by taking advantage of the provided shell scripts in `sh`).

## Examples
Assume that
1. you have cloned the repository,
2. have MATLAB running, and
3. your current working directory is `src`.

### Estimate SP-GARCH for Intel:
```
addpath('spgarch');
spgarch_est_job('data_intc.mat', 'spgarch_est_intc.mat');
load('spgarch_est_intc.mat');
plot(xSpl, YSpl);
```
`spgarch_est_intc.mat` is the saved output file containing the estimation results. Each output file contains the following variables:
* `D` - date vectors.
* `r` - returns.
* `rngState` - random generator state.
* `Sigma` - estimated conditional volatilities.
* `xSpl` - equally spaced grid at which the coefficient function is evaluated.
* `YSpl` - values of the estimated coefficient function evaluated at `xSpl`.
* `accRate` - acceptance rate of the MCMC.
* `Chain` - sampled model parameters.
* `Model` - sampled knot configurations.
