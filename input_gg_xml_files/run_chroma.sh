#!/bin/bash
#SBATCH -A m2322_g
#SBATCH -o logs/%x_%j.out
#SBATCH -e logs/%x_%j.err
#SBATCH --nodes=8
#SBATCH -t 00:10:00
#SBATCH --exclusive
#SBATCH -q regular
#SBATCH -C gpu
#SBATCH --gpus-per-node=4
##SBATCH --mail-type=ALL
##SBATCH --mail-user=hari1729@nmsu.edu

source /pscratch/sd/h/hari_8/nEDM_project_LANL/build_script_28Feb2025/env.sh
module load PrgEnv-gnu craype-accel-nvidia80 cudatoolkit/12.2
export CRAY_ACCEL_TARGET=nvidia80
export CRAY_CPU_TARGET=x86-64
export MPICH_GPU_SUPPORT_ENABLED=1

xml_input="$1"
CFG=$(basename "$xml_input" .xml | sed 's/^input_gg_cfg_//; s/_GFlow$//')

PIPE=./cfg_${CFG}.fifo
rm -f "$PIPE"; mkfifo "$PIPE"
envsubst '${CFG}' < input_cfg_SEED_GFlow.xml > "$PIPE" &
BIN=/pscratch/sd/h/hari_8/nEDM_project_LANL/build_script_28Feb2025/install/chroma_lanl/bin/chroma
srun -N 8 -n 32 -c 16 --ntasks-per-node=4 \
    $BIN -geom 1 2 2 8 -i "$PIPE" -o /pscratch/sd/h/hari_8/production_nEDM_LANL/output_gg_flow/out_qtop_ggg_allFLOW_cfg_${CFG}.xml > log2pt3pt_${CFG}
wait; rm -f "$PIPE"

