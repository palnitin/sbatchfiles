#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=amdtest
#SBATCH -o /shared/out/namd3_slurm-%j.out
#SBATCH -e /shared/out/namd3_slurm-%j.err

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/namd3_3.0a9.sifcp -r /examples ./
singularity run --bind ./examples:/examples --pwd /examples /shared/apps/bin/namd2.15a2-20211101.sif /opt/namd/bin/namd2 jac/jac.namd +p64 +setcpuaffinity +devices 0 > jac.log
singularity run --bind ./examples:/examples --pwd /examples /shared/apps/bin/namd3_3.0a9.sif /opt/namd/bin/namd2 apoa1/apoa1.namd +p64 +setcpuaffinity +devices 0 > apoa1.log
singularity run --bind ./examples:/examples --pwd /examples /shared/apps/bin/namd3_3.0a9.sif /opt/namd/bin/namd2 f1atpase/f1atpase.namd +p64 +setcpuaffinity +devices 0 > f1atpase.log
singularity run --bind ./examples:/examples --pwd /examples /shared/apps/bin/namd3_3.0a9.sif /opt/namd/bin/namd2 stmv/stmv.namd +p64 +setcpuaffinity +devices 0 > stmv.log
