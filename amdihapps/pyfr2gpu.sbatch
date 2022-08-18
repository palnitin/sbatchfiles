#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=$SLURM_JOB_USER
#SBATCH -o pyfr_slurm-%j.out
#SBATCH -e pyfr_slurm-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.1

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --bind ./benchmark:/benchmark /shared/$SLURM_CLUSTER_NAME/apps/bin/pyfr1.13.0_44.sif /bin/bash -c "run-benchmark BSF --ngpus 1"
singularity run --bind ./benchmark:/benchmark /shared/$SLURM_CLUSTER_NAME/apps/bin/pyfr1.13.0_44.sif /bin/bash -c "run-benchmark tgv --ngpus 1"
