#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=20
#SBATCH --mem=64GB
#SBATCH -o lammps4gpu_benchmark-%j.out
#SBATCH -e lammps4gpu_benchmark-%j.err
#SBATCH --gres=gpu:4

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps.sif /opt/lammps/tpl/openmpi/bin/mpirun -np 4 /opt/lammps/bin/lmp -k on g 1 -sf kk -pk kokkos cuda/aware on neigh full comm device neigh/qeq full newton on -v x 8 -v y 8 -v z 8 -v steps 600 -in in.lj -nocite -log /tmp/gpu/lj//log.lammps

