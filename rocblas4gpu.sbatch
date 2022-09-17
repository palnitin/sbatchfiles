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

singularity run /shared/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 0 &
singularity run /shared/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 1 &
singularity run /shared/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 2 &
singularity run /shared/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 3 & 

wait
