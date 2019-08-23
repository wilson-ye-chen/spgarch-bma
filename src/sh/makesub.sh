#!/bin/bash
#
# Usage: makesub.sh prjt job_name wall_time n_cpu mmry cmd
# Purpose:
# Generate a PBS job submission script for Artemis. This script is
# highly platform and job dependent, and thus shall be modified as
# needed.
#
# Author: Wilson Ye Chen <yche5077@uni.sydney.edu.au>
# Date:   August 23, 2019

prjt=$1
job_name=$2
wall_time=$3
n_cpu=$4
mmry=$5
cmd=$6

echo "#!/bin/bash"
echo "#PBS -P $prjt"
echo "#PBS -N $job_name"
echo "#PBS -M yche5077@uni.sydney.edu.au"
echo "#PBS -m ae"
echo "#PBS -q defaultQ"
echo "#PBS -l walltime=$wall_time"
echo "#PBS -l ncpus=$n_cpu"
echo "#PBS -l mem=$mmry"
echo "#PBS -k oe"
echo "cd \$PBS_O_WORKDIR"
echo "module load matlab/R2016b"
echo "mkdir -p /tmp/yche5077"
echo "export MATLAB_PREFDIR=/tmp/yche5077"
echo "$cmd"
