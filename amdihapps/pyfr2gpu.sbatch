#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=$USER
#SBATCH -o pyfr2gpu_benchmark-%j.out
#SBATCH -e pyfr2gpu_benchmark-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --bind ./benchmark:/benchmark /shared/$SLURM_CLUSTER_NAME/apps/bin/pyfr1.13.0_44.sif /bin/bash -c "run-benchmark BSF --ngpus 2"
singularity run --bind ./benchmark:/benchmark /shared/$SLURM_CLUSTER_NAME/apps/bin/pyfr1.13.0_44.sif /bin/bash -c "run-benchmark tgv --ngpus 2"
