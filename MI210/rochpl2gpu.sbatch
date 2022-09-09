#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=20
#SBATCH --time=167:00:00
#SBATCH --mem=64GB
#SBATCH -o rochpl2gpu_benchmark-%j.out
#SBATCH -e rochpl2gpu_benchmark-%j.err
#SBATCH --gres=gpu:2

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /tmp --writable-tmpfs /shared/apps/bin/rochpl_5.0.5_49.sif /bin/bash mpirun_rochpl -P 1 -Q 2 -N 128000 --NB 512 
