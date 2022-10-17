#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=16
#SBATCH --mem=0
#SBATCH --gres=gpu:8

#SBATCH -o %x-%N-%j.out
#SBATCH -e %x-%N-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.3.0

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/rocmtests_5.3.0-ub20.sif /home/rccl-tests/build/all_reduce_perf -b 8 -e 16G -f 2 -g 8 -c 0

rm -rf $tmp
