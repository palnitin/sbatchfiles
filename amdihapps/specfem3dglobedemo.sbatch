#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH --job-name=$SLURM_JOB_USER
#SBATCH -o specfem3dglobe_slurm-%j.out
#SBATCH -e specfem3dglobe_slurm-%j.err

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/$SLURM_CLUSTER_NAME/apps/bin/specfem3d_globe1ee10977-20210321.sif /bin/bash -c "cp -r /opt/specfem3d_globe ./"
singularity run --bind ./specfem3d_globe:/opt/specfem3d_globe /shared/$SLURM_CLUSTER_NAME/apps/bin/specfem3d_globe1ee10977-20210321.sif /bin/bash -c "benchmark global_s362ani_shakemovie -o /tmp/out"
singularity run --bind ./specfem3d_globe:/opt/specfem3d_globe /shared/$SLURM_CLUSTER_NAME/apps/bin/specfem3d_globe1ee10977-20210321.sif /bin/bash -c "cd /opt/specfem3d_globe/EXAMPLES/regional_Greece_small; ./run_this_example.sh"
