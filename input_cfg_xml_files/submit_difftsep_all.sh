#!/usr/bin/env bash

mkdir -p logs

for xml in input_cfg_difftsep_*_GFlow.xml; do
  CFG=${xml#input_cfg_difftsep_}
  CFG=${CFG%_GFlow.xml}

  echo "Submitting job for CFG=${CFG}..."
  sbatch \
    --export=ALL,CFG="$CFG" \
    --job-name=cfg_${CFG} \
    chroma_job_difftsep.sbatch
done

