#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=64GB
#SBATCH --gres=gpu:1
#SBATCH -o %x-%N-%j.err
#SBATCH -e %x-%N-%j.out

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/gpu1-$$
mkdir -p $tmp

#===== ADH-DODEC Benchmark, Threaded-MPI
mkdir -p /tmp/$USER/gpu1-$$/adh_dodec
singularity run /shared/apps/bin/gromacs.sif tar -xvf /benchmarks/adh_dodec/adh_dodec.tar.gz -C /tmp/$USER/gpu1-$$/adh_dodec 1>/dev/null
singularity run /shared/apps/bin/gromacs.sif gmx mdrun -pin on -nsteps 100000 -resetstep 90000 -ntmpi 1 -ntomp 64 -noconfout -nb gpu -bonded gpu -pme gpu -v -nstlist 100 -gpu_id 0 -s /tmp/$USER/gpu1-$$/adh_dodec/topol.tpr -g /tmp/$USER/gpu1-$$/adh_dodec/md.log -e /tmp/$USER/gpu1-$$/adh_dodec/ener.eder -cpo /tmp/$USER/gpu1-$$/adh_dodec/state.cpt

#===== CELLULOSE_NVE Benchmark, Threaded-MPI
mkdir -p /tmp/$USER/gpu1-$$/cellulose_nve
singularity run /shared/apps/bin/gromacs.sif tar -xvf /benchmarks/cellulose_nve/cellulose_nve.tar.gz -C /tmp/$USER/gpu1-$$/cellulose_nve 1>/dev/null
singularity run /shared/apps/bin/gromacs.sif gmx mdrun -pin on -nsteps 100000 -resetstep 90000 -ntmpi 1 -ntomp 64 -noconfout -nb gpu -bonded gpu -pme gpu -v -nstlist 100 -gpu_id 0 -s /tmp/$USER/gpu1-$$/cellulose_nve/topol.tpr -g /tmp/$USER/gpu1-$$/cellulose_nve/md.log -e /tmp/$USER/gpu1-$$/cellulose_nve/ener.eder -cpo /tmp/$USER/gpu1-$$/cellulose_nve/state.cpt

# STMV Benchmark, Threaded-MPI
mkdir -p /tmp/$USER/gpu1-$$/stmv
singularity run /shared/apps/bin/gromacs.sif tar -xvf /benchmarks/stmv/stmv.tar.gz -C /tmp/$USER/gpu1-$$/stmv 1>/dev/null
singularity run /shared/apps/bin/gromacs.sif gmx mdrun -pin on -nsteps 100000 -resetstep 90000 -ntmpi 1 -ntomp 64 -noconfout -nb gpu -bonded gpu -pme gpu -v -nstlist 200 -gpu_id 0 -s /tmp/$USER/gpu1-$$/stmv/topol.tpr -g /tmp/$USER/gpu1-$$/stmv/md.log -e /tmp/$USER/gpu1-$$/stmv/ener.eder -cpo /tmp/$USER/gpu1-$$/stmv/state.cpt

cp -r /tmp/$USER/gpu1-$$   $PWD/gpu1-$$-$SLURM_JOB_NODELIST-$SLURM_JOB_ID

# Do the clean-up
/bin/rm -rf $tmp
