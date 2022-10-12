#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=8
#SBATCH --mem=64GB
#SBATCH --gres=gpu:8
#SBATCH -o %x-%N-%j.out
#SBATCH -e %x-%N-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/namd3_3.0a9.sif cp -r /examples ./examples-$$
singularity run --bind ./examples-$$:/examples-$$ --pwd /examples-$$ /shared/apps/bin/namd3_3.0a9.sif /opt/namd/bin/namd3 jac/jac.namd +p1 +setcpuaffinity --CUDASOAintegrate on +devices 0,1,2,3,4,5,6,7
singularity run --bind ./examples-$$:/examples-$$ --pwd /examples-$$ /shared/apps/bin/namd3_3.0a9.sif /opt/namd/bin/namd3 apoa1/apoa1.namd +p1 +setcpuaffinity --CUDASOAintegrate on +devices 0,1,2,3,4,5,6,7
singularity run --bind ./examples-$$:/examples-$$ --pwd /examples-$$ /shared/apps/bin/namd3_3.0a9.sif /opt/namd/bin/namd3 f1atpase/f1atpase.namd +p1 +setcpuaffinity --CUDASOAintegrate on +devices 0,1,2,3,4,5,6,7 
singularity run --bind ./examples-$$:/examples-$$ --pwd /examples-$$ /shared/apps/bin/namd3_3.0a9.sif /opt/namd/bin/namd3 stmv/stmv.namd +p1 +setcpuaffinity --CUDASOAintegrate on +devices 0,1,2,3,4,5,6,7

cp -r ./examples-$$   $PWD/gpu8-$$-$SLURM_JOB_NODELIST-$SLURM_JOB_ID

rm -rf examples-$$/
