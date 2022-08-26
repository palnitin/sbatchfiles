#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH -o specfem3dcart_benchmark-%j.out
#SBATCH -e specfem3dcart_benchmark-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run --pwd /opt/specfem3d/EXAMPLES/homogeneous_poroelastic --writable-tmpfs /shared/$SLURM_CLUSTER_NAME/apps/bin/specfem3d_9c0626d1-20201122.sif /bin/bash ./run_this_example.sh
