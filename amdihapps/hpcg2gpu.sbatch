#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=20
#SBATCH --time=167:00:00
#SBATCH --mem=64GB
#SBATCH -o hpcg2gpu_benchmark-%j.out
#SBATCH -e hpcg2gpu_benchmark-%j.err
#SBATCH --gres=gpu:2 

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/rochpcg3.1.0_97.sif mpirun -np 2 hpcg 280 280 280 1860
