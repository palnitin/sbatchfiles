#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=20
#SBATCH --time=167:00:00
#SBATCH --mem=64GB
#SBATCH -o rochpl8gpu_benchmark-%j.out
#SBATCH -e rochpl8gpu_benchmark-%j.err
#SBATCH --gres=gpu:8

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/rochpl_5.0.5_49.sif mpirun_rochpl mpirun_rochpl -P 2 -Q 4 -N 256000 --NB 512
