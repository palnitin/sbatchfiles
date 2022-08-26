#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=4
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH -o lammps2gpu_benchmark-%j.out
#SBATCH -e lammps2gpu_benchmark-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /benchmark --writable-tmpfs /shared/$SLURM_CLUSTER_NAME/apps/bin/lammps.sif /bin/bash ./benchmark.sh --mode run --prefix /opt/lammps --gpu-aware-mpi --comm device --with-mpi /opt/lammps/tpl/openmpi --kokkos-gpu-arch VEGA90a --ngpus 2 --memsize 32 --out-label /tmp/gpu2

