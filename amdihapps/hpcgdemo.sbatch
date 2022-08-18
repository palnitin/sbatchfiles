#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=amdtest
#SBATCH -o /shared/out/hpcg_slurm-%j.out
#SBATCH -e /shared/out/hpcg_slurm-%j.err

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/binrochpcg3.1.0_97.sif mpirun -np 1 hpcg 280 280 280 1860
