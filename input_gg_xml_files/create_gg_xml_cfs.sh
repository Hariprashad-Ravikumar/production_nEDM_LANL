#!/bin/bash
TEMPLATE=/pscratch/sd/h/hari_8/production_nEDM_LANL/input_ggg_SEED.xml
DIR=/global/cfs/cdirs/m2322/Lattices/cl21_32_64_b6p3_m0p2390_m0p2050

for f in "$DIR"/cl21_32_64_b6p3_m0p2390_m0p2050_cfg_*.lime.ref*; do
  # extract ONLY the cfg identifier (e.g. "6024.lime.ref1000" or just "6024")
  filename=$(basename "$f")
  CFGNUM=${filename#*cfg_}
  CFGNUM=${CFGNUM%%.lime*}

  FULLPATH="$f"
  out="input_gg_cfg_${CFGNUM}_GFlow.xml"

  sed \
    -e "s|__FULLPATH__|$FULLPATH|g" \
    -e "s|__CFGNUM__|$CFGNUM|g" \
    "$TEMPLATE" > "$out"

  echo "→ $out"
done



