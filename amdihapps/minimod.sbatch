#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --time=167:00:00
#SBATCH --mem=64GB
#SBATCH -o minimod_benchmark-%j.out
#SBATCH -e minimod_benchmark-%j.err
#SBATCH --gres=gpu:1

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/minimod.sif benchmark-acousticISO
