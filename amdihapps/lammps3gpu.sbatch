#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=3
#SBATCH --cpus-per-task=20
#SBATCH --mem=64GB
#SBATCH -o lammps3gpu_benchmark-%j.out
#SBATCH -e lammps3gpu_benchmark-%j.err
#SBATCH --gres=gpu:3

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/lammps.sif /bin/bash ./benchmark.sh --mode run --prefix /opt/lammps --gpu-aware-mpi --comm device --with-mpi /opt/lammps/tpl/openmpi --kokkos-gpu-arch VEGA90a --ngpus 3 --memsize 32 --out-label /tmp/gpu3

