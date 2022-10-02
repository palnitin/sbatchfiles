#!/bin/bash
# Copyright (c) 2022 Advanced Micro Devices, Inc. All Rights Reserved.

#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=$SLURM_JOB_USER
#SBATCH -o %x-%N-%j.out
#SBATCH -e %x-%N-%j.err

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

source /etc/profile.d/modules.sh

module load rocm/5.2.1
module load ompi/5.0.x
module load ucx/1.13.0
module list

mpirun -np 2 -x UCX_RNDV_PIPELINE_SEND_THRESH=256k -x UCX_RNDV_FRAG_SIZE=rocm:4m -x UCX_RNDV_THRESH=64 --mca osc ucx --mca spml ucx -x UCX_LOG_LEVEL=TRACE_DATA -mca pml ucx -x UCX_TLS=sm,self,rocm_copy,rocm_ipc /shared/apps/osu-micro-benchmarks-5.9/mpi/pt2pt/osu_bw -d rocm D D

