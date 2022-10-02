#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=12GB
#SBATCH -o %x-%N-%j.out
#SBATCH -e %x-%N-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm-5.2.0/rvs/rvs -c /opt/rocm-5.2.0/share/rocm-validation-suite/conf/pqt_single.conf
