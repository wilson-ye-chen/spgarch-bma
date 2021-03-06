#!/bin/bash
#
# Usage: sub_spgarch_est_ss1.sh key
# Purpose:
# Submit an estimation job for the empirical study of the SP-GARCH model.
# This version of the script is written for the Artemis cluster of the
# University of Sydney.
#
# Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
# Date:   August 23, 2019

key=$1

DATAFILE=/project/spgarch-bma/src/spgarch/data_ss1_$key.mat
OUTFILE=/project/spgarch-bma/out/est_spgarch_ss1/spgarch_est_$key.mat
PROJECT=spgarch-bma
JOBNAME=sp_$key
WALLTIME=48:00:00
NCPUS=1
MEM=2GB

cmd="matlab -r \" \
    addpath('/project/spgarch-bma/src/spgarch'); \
    try, spgarch_est_job('$DATAFILE', '$OUTFILE'), \
    catch Ex, disp(Ex.message); exit(1), end, exit(0);\" \
    -nosplash -nodisplay -nodesktop -nojvm -singleCompThread"
./makesub.sh \
    $PROJECT \
    $JOBNAME \
    $WALLTIME \
    $NCPUS \
    $MEM \
    "$cmd" \
    | qsub
echo "Submission complete."
