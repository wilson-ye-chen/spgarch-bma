#!/bin/bash
#
# Usage: sub_garch_sim_dgp3.sh start end
# Purpose:
# Submit a batch of jobs for the simulation study of the GARCH-t model.
# This version of the script is written for the Artemis cluster of the
# University of Sydney.
#
# Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
# Date:   February 13, 2017

start=$1
end=$2

DATAFILE=/project/symbolic/src/SemiParGarch3/data_dgp3.mat
OUTNAME=/project/symbolic/out/spline/sim_garch/dgp3/garch_dgp3_
PROJECT=symbolic
JOBNAME=garch_dgp3_
WALLTIME=1:00:00
NCPUS=1
MEM=1024mb

for ((i = $start; i <= $end; i++))
do
    cmd="matlab -r \" \
        addpath('/project/symbolic/src/Garch'); \
        addpath('/project/symbolic/src/SemiParGarch3'); \
        try, garch_sim_job('$DATAFILE', '$OUTNAME$i.mat', '$i'), \
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
