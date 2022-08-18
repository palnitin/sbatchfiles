#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=amdtest
#SBATCH -o /shared/out/chroma_slurm-%j.out
#SBATCH -e /shared/out/chroma_slurm-%j.err

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/chroma_3.43.0-20211118.sif run-benchmark --ngpus 2
