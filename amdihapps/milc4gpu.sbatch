#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=20
#SBATCH --mem=64GB
#SBATCH -o milc4gpu_benchmark-%j.out
#SBATCH -e milc4gpu_benchmark-%j.err
#SBATCH --gres=gpu:4

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /benchmark --writable-tmpfs /shared/apps/bin/milc_c30ed15e1.sif /bin/bash run-benchmark --ngpus 4 -o bench-gpu4.txt
