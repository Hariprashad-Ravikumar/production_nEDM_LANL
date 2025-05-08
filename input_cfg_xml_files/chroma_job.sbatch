#!/usr/bin/env bash
#SBATCH -A m2322_g
#SBATCH -o logs/cfg_${CFG}_%j.out
#SBATCH -e logs/cfg_${CFG}_%j.err
#SBATCH --nodes=8
#SBATCH -t 02:30:00
#SBATCH --exclusive
#SBATCH -q regular
#SBATCH -C gpu
#SBATCH --gpus-per-node=4
##SBATCH --mail-type=ALL
##SBATCH --mail-user=hari1729@nmsu.edu

# your environment
source /pscratch/sd/h/hari_8/nEDM_project_LANL/build_script_28Feb2025/env.sh
module load PrgEnv-gnu craype-accel-nvidia80 cudatoolkit/12.2
export CRAY_ACCEL_TARGET=nvidia80
export CRAY_CPU_TARGET=x86-64
export MPICH_GPU_SUPPORT_ENABLED=1

# path to Chroma binary
BIN=/pscratch/sd/h/hari_8/nEDM_project_LANL/build_script_28Feb2025/install/chroma_lanl/bin/chroma

# construct filenames from $CFG
XML="input_cfg_${CFG}_GFlow.xml"

echo "[$SLURM_JOB_ID] Running CFG=${CFG} → $XML"
srun -N 8 \
     -n 32 \
     -c 16 \
     --ntasks-per-node=4 \
     $BIN -geom 1 2 2 8 -i "$XML" \
     > "log2pt3pt_${CFG}.log"

