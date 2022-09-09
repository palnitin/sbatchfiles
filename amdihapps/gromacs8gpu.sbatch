#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=20
#SBATCH --time=167:00:00
#SBATCH --mem=64GB
#SBATCH -o gromacs8gpu_benchmark-%j.out
#SBATCH -e gromacs8gpu_benchmark-%j.err
#SBATCH --gres=gpu:8

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/gromacs.sif tar -xvf /benchmarks/stmv/stmv.tar.gz
singularity run /shared/apps/bin/gromacs.sif mpirun -np 8 gmx_mpi mdrun -nsteps 100000 -resetstep 90000 -ntomp 8 -noconfout -nb gpu -bonded cpu -pme gpu -npme 1 -v -nstlist 400 -gpu_id 01234567 -s topol.tpr
