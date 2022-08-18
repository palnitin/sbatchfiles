#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=$SLURM_JOB_USER
#SBATCH -o hpcg4gpu_benchmark-%j.out
#SBATCH -e hpcg4gpu_benchmark-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.1

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/$SLURM_CLUSTER_NAME/apps/binrochpcg3.1.0_97.sif mpirun -np 4 hpcg 280 280 280 1860
