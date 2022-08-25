#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=8
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH -o cp2k4gpu_benchmark-%j.out
#SBATCH -e cp2k4gpu_benchmark-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --writable-tmpfs --bind $(pwd):/tmp /shared/$SLURM_CLUSTER_NAME/apps/bin/cp2k.sif benchmark 32-H2O-RPA --arch VEGA908 --gpu-count 4 --cpu-count 64 --omp-thread-count 4 --ranks 16 --rank-stride 4 --output /tmp/32-H2O-RPA-4GPU
