#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=$SLURM_JOB_USER
#SBATCH -o gromacs_slurm-%j.out
#SBATCH -e gromacs_slurm-%j.err

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/$SLURM_CLUSTER_NAME/apps/bin/gromacs.sif tar -xvf /benchmarks/stmv/stmv.tar.gz
singularity run /shared/$SLURM_CLUSTER_NAME/apps/bin/gromacs.sif mpirun -np 8 gmx_mpi mdrun -nsteps 100000 -resetstep 90000 -ntomp 8 -noconfout -nb gpu -bonded cpu -pme gpu -npme 1 -v -nstlist 400 -gpu_id 01234567 -s topol.tpr
