#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=$USER
#SBATCH -o chroma2gpu_benchmark-%j.out
#SBATCH -e chroma2gpu_benchmark-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /benchmark --writable-tmpfs /shared/$SLURM_CLUSTER_NAME/apps/bin/chroma_3.43.0-20211118.sif run-benchmark --ngpus 2
