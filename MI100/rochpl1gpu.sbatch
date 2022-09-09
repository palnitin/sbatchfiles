#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10
#SBATCH --time=167:00:00
#SBATCH --mem=32GB
#SBATCH -o rochpl1gpu_MI100_benchmark-%j.out
#SBATCH -e rochpl1gpu_MI100_benchmark-%j.err
#SBATCH --gres=gpu:1

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /tmp --writable-tmpfs /shared/apps/bin/rochpl_5.0.5_49.sif /bin/bash mpirun_rochpl -P 1 -Q 1 -N 64128 --NB 512
