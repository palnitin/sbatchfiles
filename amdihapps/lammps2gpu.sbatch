#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=20
#SBATCH --mem=64GB
#SBATCH --gres=gpu:2
#SBATCH -o %x-%N-%j.out
#SBATCH -e %x-%N-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps.sif /opt/lammps/tpl/openmpi/bin/mpirun -np 2 /opt/lammps/bin/lmp -k on g 1 -sf kk -pk kokkos cuda/aware on neigh full comm device neigh/qeq full newton on -v x 8 -v y 8 -v z 8 -v steps 600 -in in.lj -nocite -log /tmp/gpu/lj//log.lammps

