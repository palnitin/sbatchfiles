#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=20
#SBATCH --time=167:00:00
#SBATCH --mem=64GB
#SBATCH -o rochpl4gpu_benchmark-%j.out
#SBATCH -e rochpl4gpu_benchmark-%j.err
#SBATCH --gres=gpu:4

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /tmp --writable-tmpfs /shared/apps/bin/rochpl.sif /bin/bash mpirun_rochpl -P 2 -Q 2 -N 181248 --NB 512 
