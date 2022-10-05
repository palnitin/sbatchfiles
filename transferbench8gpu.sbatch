#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=128GB
#SBATCH --gres=gpu:8
#SBATCH -o %x-%N-%j.out
#SBATCH -e %x-%N-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.3.0

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/rocmtests_5.3.0-ub20.sif /home/rccl/tools/TransferBench/TransferBench

singularity run /shared/apps/bin/rocmtests_5.3.0-ub20.sif /home/rccl/tools/TransferBench/TransferBench p2p

singularity run /shared/apps/bin/rocmtests_5.3.0-ub20.sif /home/rccl/tools/TransferBench/TransferBench g2g

rm -rf $tmp
