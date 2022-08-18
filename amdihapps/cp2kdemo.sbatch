#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=amdtest
#SBATCH -o /shared/out/cp2k_slurm-%j.out
#SBATCH -e /shared/out/cp2k_slurm-%j.err

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --writable-tmpfs --bind $(pwd):/tmp /shared/apps/bin/cp2k.sif benchmark 32-H2O-RPA --arch VEGA908 --gpu-count 4 --cpu-count 64 --omp-thread-count 4 --ranks 16 --rank-stride 4 --output /tmp/32-H2O-RPA-4GPU
