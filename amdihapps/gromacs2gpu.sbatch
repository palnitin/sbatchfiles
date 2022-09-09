#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=20
#SBATCH --time=167:00:00
#SBATCH --mem=64GB
#SBATCH -o gromacs2gpu_benchmark-%j.out
#SBATCH -e gromacs2gpu_benchmark-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/gromacs.sif tar -xvf /benchmarks/stmv/stmv.tar.gz
singularity run /shared/apps/bin/gromacs.sif mpirun -np 2 gmx_mpi mdrun -nsteps 100000 -resetstep 90000 -ntomp 16 -noconfout -nb gpu -bonded cpu -pme gpu -npme 1 -v -nstlist 200 -gpu_id 01 -s topol.tpr
