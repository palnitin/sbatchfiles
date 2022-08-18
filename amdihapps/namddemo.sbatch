#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=$SLURM_JOB_USER
#SBATCH -o namd_slurm-%j.out
#SBATCH -e namd_slurm-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.1

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/$SLURM_CLUSTER_NAME/apps/bin/namd2.15a2-20211101.sif cp -r /examples ./
singularity run --bind ./examples:/examples --pwd /examples /shared/$SLURM_CLUSTER_NAME/apps/bin/namd2.15a2-20211101.sif /opt/namd/bin/namd2 jac/jac.namd +p64 +setcpuaffinity +devices 0 > jac.log
singularity run --bind ./examples:/examples --pwd /examples /shared/$SLURM_CLUSTER_NAME/apps/bin/namd2.15a2-20211101.sif /opt/namd/bin/namd2 apoa1/apoa1.namd +p64 +setcpuaffinity +devices 0 > apoa1.log
singularity run --bind ./examples:/examples --pwd /examples /shared/$SLURM_CLUSTER_NAME/apps/bin/namd2.15a2-20211101.sif /opt/namd/bin/namd2 f1atpase/f1atpase.namd +p64 +setcpuaffinity +devices 0 > f1atpase.log
singularity run --bind ./examples:/examples --pwd /examples /shared/$SLURM_CLUSTER_NAME/apps/bin/namd2.15a2-20211101.sif /opt/namd/bin/namd2 stmv/stmv.namd +p64 +setcpuaffinity +devices 0 > stmv.log
