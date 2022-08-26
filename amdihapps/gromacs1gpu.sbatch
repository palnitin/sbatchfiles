#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH -o gromacs8gpu_benchmark-%j.out
#SBATCH -e gromacs8gpu_benchmark-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/$SLURM_CLUSTER_NAME/apps/bin/gromacs.sif tar -xvf /benchmarks/stmv/stmv.tar.gz
singularity run /shared/$SLURM_CLUSTER_NAME/apps/bin/gromacs.sif mpirun -np 1 gmx_mpi mdrun -nsteps 100000 -resetstep 90000 -ntomp 64 -noconfout -nb gpu -bonded cpu -pme gpu -npme 1 -v -nstlist 100 -gpu_id 0 -s topol.tpr
