#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=20
#SBATCH --mem=64GB
#SBATCH -o lammps8gpu_benchmark-%j.out
#SBATCH -e lammps8gpu_benchmark-%j.err
#SBATCH --gres=gpu:8

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps.sif /opt/lammps/tpl/openmpi/bin/mpirun -np 8 /opt/lammps/bin/lmp -k on g 8 -sf kk -pk kokkos cuda/aware on neigh full comm device neigh/qeq full newton on -v x 16 -v y 16 -v z 16 -v steps 600 -in in.lj -nocite -log /tmp/gpu/lj//log.lammps 

