#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=10
#SBATCH --time=167:00:00
#SBATCH --mem=64GB
#SBATCH -o pyfr1gpu_benchmark-%j.out
#SBATCH -e pyfr1gpu_benchmark-%j.err
#SBATCH --gres=gpu:1

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/pyfr1.13.0_44.sif /bin/bash -c "cp -r /benchmark ./"
singularity run --bind ./benchmark:/benchmark /shared/apps/bin/pyfr1.13.0_44.sif /bin/bash -c "run-benchmark BSF --ngpus 1"
singularity run --bind ./benchmark:/benchmark /shared/apps/bin/pyfr1.13.0_44.sif /bin/bash -c "run-benchmark tgv --ngpus 1"
