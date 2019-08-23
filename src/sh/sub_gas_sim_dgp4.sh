#!/bin/bash
#
# Usage: sub_gas_sim_dgp4.sh start end
# Purpose:
# Submit a batch of jobs for the simulation study of the GAS-t model.
# This version of the script is written for the Artemis cluster of the
# University of Sydney.
#
# Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
# Date:   August 23, 2019

start=$1
end=$2

DATAFILE=/project/spgarch-bma/src/spgarch/data_dgp4.mat
OUTNAME=/project/spgarch-bma/out/sim_gas/dgp4/gas_dgp4_
PROJECT=spgarch-bma
JOBNAME=gas_dgp4_
WALLTIME=1:00:00
NCPUS=1
MEM=1024mb

for ((i = $start; i <= $end; i++))
do
    cmd="matlab -r \" \
        addpath('/project/spgarch-bma/src/garch'); \
        addpath('/project/spgarch-bma/src/spgarch'); \
        try, gas_sim_job('$DATAFILE', '$OUTNAME$i.mat', '$i'), \
        catch Ex, disp(Ex.message); exit(1), end, exit(0);\" \
        -nosplash -nodisplay -nodesktop -nojvm -singleCompThread"
    ./makesub.sh \
        $PROJECT \
        $JOBNAME$i \
        $WALLTIME \
        $NCPUS \
        $MEM \
        "$cmd" \
        | qsub
done
echo "Submission complete."
