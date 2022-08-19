#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=$SLURM_JOB_USER
#SBATCH -o milc_slurm-%j.out
#SBATCH -e milc_slurm-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /benchmark --writable-tmpfs /shared/$SLURM_CLUSTER_NAME/apps/bin/milc_c30ed15e1.sif /bin/bash run-benchmark --ngpus 1 -o bench-gpu1.txt
