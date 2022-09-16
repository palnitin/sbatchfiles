#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=64GB
#SBATCH -o chroma1gpu_benchmark-%j.out
#SBATCH -e chroma1gpu_benchmark-%j.err
#SBATCH --gres=gpu:1

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/chroma_3.43.0-20211118.sif run-benchmark --ngpus 1
