#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH -o rvspqt-%j.out
#SBATCH -e rvspqt-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/$SLURM_CLUSTER_NAME/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm-5.2.0/rvs/rvs -c /opt/rocm-5.2.0/share/rocm-validation-suite/conf/pqt_single.conf
