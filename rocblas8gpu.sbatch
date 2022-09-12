#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=20
#SBATCH --time=167:00:00
#SBATCH --mem=64GB
#SBATCH -o rocblas8gpu_bench-5.2-%j.out
#SBATCH -e rocblas8gpu_bench-5.2-%j.err
#SBATCH --gres=gpu:8
source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 0 &
singularity run /shared/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 1 &
singularity run /shared/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 2 &
singularity run /shared/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 3 &
singularity run /shared/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 4 &
singularity run /shared/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 5 &
singularity run /shared/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 6 &
singularity run /shared/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 7 &

wait
