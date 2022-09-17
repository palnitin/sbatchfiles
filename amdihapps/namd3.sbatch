#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=64GB
#SBATCH --gres=gpu:4
#SBATCH -o %x-%N-%j.out
#SBATCH -e %x-%N-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/namd3_3.0a9.sif cp -r /examples ./
singularity run --bind ./examples:/examples --pwd /examples /shared/apps/bin/namd2.15a2-20211101.sif /opt/namd/bin/namd2 jac/jac.namd +p64 +setcpuaffinity +devices 0 > jac.log &
singularity run --bind ./examples:/examples --pwd /examples /shared/apps/bin/namd3_3.0a9.sif /opt/namd/bin/namd2 apoa1/apoa1.namd +p64 +setcpuaffinity +devices 0 > apoa1.log &
singularity run --bind ./examples:/examples --pwd /examples /shared/apps/bin/namd3_3.0a9.sif /opt/namd/bin/namd2 f1atpase/f1atpase.namd +p64 +setcpuaffinity +devices 0 > f1atpase.log &
singularity run --bind ./examples:/examples --pwd /examples /shared/apps/bin/namd3_3.0a9.sif /opt/namd/bin/namd2 stmv/stmv.namd +p64 +setcpuaffinity +devices 0 > stmv.log &

wait
