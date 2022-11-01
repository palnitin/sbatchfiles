#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=8
#SBATCH --mem=64GB
#SBATCH --gres=gpu:8
#SBATCH -o %x-%N-%j.out
#SBATCH -e %x-%N-%j.err

module load rocm/5.3.0

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

module avail
module list
rocm-smi
rocminfo
clinfo
which srun
which singularity
which python3
pip3 list
which gcc
singularity --version
python3 --version
gcc --version
g++ --version
amdclang --version
hipcc --version
cmake --version


exit 0

