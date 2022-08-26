# sbatchfiles
## Useful Parameters
  - --cpus-per-gpu=
  - -c | --cpus-per-task=
  - -d, --dependency=
  - --ntasks-per-node=
  - -G, --gpus=
  - -t, --time=
  - --gpus-per-node=
  - --gpus-per-task=
  - --gres=
  - -h, --help
  - -H, --hold (scontrol release job_id)
  - -J, --job-name=
  - --mem=
  - --mem-per-cpu=
  - --mem-per-gpu=
  - -w, --nodelist=
  - -N, --nodes=
  - --ntasks-per-gpu=
  - --ntasks-per-node=
  - -s, --oversubscribe
  - -p, --partition=
  - -v, --verbose
  - -W, --wait
  

## sbatch templates
### .sbatch file
```
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --job-name=hostname
#SBATCH -o hostname-%j.out
#SBATCH -e hostname-%j.err

srun hostname
```
```
#!/bin/bash

#SBATCH --job-name=rocm-smi
#SBATCH -o rocm-smi-%j.out
#SBATCH -e rocm-smi-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

rocm-smi
```
```
#!/bin/bash

#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=167:00:00
#SBATCH --mem=12GB
#SBATCH -o rocblas1gpu_bench-5.2-%j.out
#SBATCH -e rocblas1gpu_bench-5.2-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/tmp-$$
mkdir -p $tmp

singularity run /shared/$SLURM_CLUSTER_NAME/apps/bin/rocm_5.2.0-ub20.sif /opt/rocm/bin/rocblas-bench -f gemm -r d -m 8640 -n 8640 -k 8640 --transposeB T --initialization trig_float -i 2000 --device 0
```
### terminal
```
sbatch -N4 <<EOF
> #!/bin/sh
> srun hostname |sort
> EOF
```
