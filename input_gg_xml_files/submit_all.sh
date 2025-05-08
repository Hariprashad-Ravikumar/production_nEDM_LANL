#!/usr/bin/env bash

# ensure logs dir exists
mkdir -p logs

for xml in input_gg_cfg_*_GFlow.xml; do
  # strip prefix/suffix
  CFG=${xml#input_gg_cfg_}
  CFG=${CFG%_GFlow.xml}

  echo "Submitting job for CFG=${CFG}..."
  sbatch \
    --export=ALL,CFG="$CFG" \
    --job-name=cfg_${CFG} \
    chroma_job.sbatch
done

