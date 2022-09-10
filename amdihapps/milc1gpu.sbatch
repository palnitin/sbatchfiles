#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --time=167:00:00
#SBATCH --mem=64GB
#SBATCH -o milc1gpu_benchmark-%j.out
#SBATCH -e milc1gpu_benchmark-%j.err
#SBATCH --gres=gpu:1

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/milc_c30ed15e1.sif /bin/bash run-benchmark --ngpus 1 -o bench-gpu1.txt
