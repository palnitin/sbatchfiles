#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=amdtest
#SBATCH -o /shared/out/rvspqt-%j.out
#SBATCH -e /shared/out/rvspqt-%j.err

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

/opt/rocm-5.2.0/rvs/rvs -c /opt/rocm-5.2.0/share/rocm-validation-suite/conf/pqt_single.conf
