#!/bin/bash
#
# Usage: sub_spgarch_sim_dgp4.sh start end
# Purpose:
# Submit a batch of jobs for the simulation study of the SPGARCH model.
# This version of the script is written for the Artemis cluster of the
# University of Sydney.
#
# Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
# Date:   February 17, 2017

start=$1
end=$2

DATAFILE=/project/symbolic/src/SemiParGarch3/data_dgp4.mat
OUTNAME=/project/symbolic/out/spline/sim_spgarch/dgp4/spgarch_dgp4_
PROJECT=symbolic
JOBNAME=sp_dgp4_
WALLTIME=48:00:00
NCPUS=1
MEM=1024mb

for ((i = $start; i <= $end; i++))
do
    cmd="matlab -r \" \
        addpath('/project/symbolic/src/Garch'); \
        addpath('/project/symbolic/src/SemiParGarch3'); \
        try, spgarch_sim_job('$DATAFILE', '$OUTNAME$i.mat', '$i'), \
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
