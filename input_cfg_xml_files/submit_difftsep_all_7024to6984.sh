#!/usr/bin/env bash

mkdir -p logs
cfgno=(7024 7020 7014 7010 7004 7000 6994 6990 6984)
for CFG in "${cfgno[@]}"; do

  echo "Submitting job for CFG=${CFG}..."
  sbatch \
    --export=ALL,CFG="$CFG" \
    --job-name=cfg_${CFG} \
    chroma_job_difftsep.sbatch
done

