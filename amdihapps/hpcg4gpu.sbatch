#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=20
#SBATCH --mem=64GB
#SBATCH -o hpcg4gpu_benchmark-%j.out
#SBATCH -e hpcg4gpu_benchmark-%j.err
#SBATCH --gres=gpu:4

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/rochpcg3.1.0_97.sif mpirun -np 4 hpcg 280 280 280 1860
