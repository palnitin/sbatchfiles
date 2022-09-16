#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=20
#SBATCH --mem=64GB
#SBATCH -o rochpl4gpu_MI100_benchmark-%j.out
#SBATCH -e rochpl4gpu_MI100_benchmark-%j.err
#SBATCH --gres=gpu:4

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/rochpl_5.0.5_49.sif mpirun_rochpl -P 2 -Q 2 -N 126976 --NB 512
