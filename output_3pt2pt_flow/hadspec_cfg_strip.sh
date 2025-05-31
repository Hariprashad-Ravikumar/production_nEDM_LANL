#!/usr/bin/env bash
set -euo pipefail


cfg_list="/pscratch/sd/h/hari_8/production_nEDM_LANL/config_numbers.txt"
mapfile -t cfg < <(awk '{print $NF}' "$cfg_list")

GFlable=(0p0 8p0 12p5 18p0)

WORKDIR=/pscratch/sd/h/hari_8/production_nEDM_LANL/output_3pt2pt_flow
BIN=/pscratch/sd/h/hari_8/nEDM_project_LANL/chromaUtilsHDF5/bin/strip_hadspec_hdf5

cd "$WORKDIR"

# Build up all the arguments into one array
args=()

for gf in "${GFlable[@]}"; do
  for c in "${cfg[@]}"; do
    pattern="FLOWED_${gf}_hadspec_*_${c}.xml"
    for f in $pattern; do
      # skip if no match
      [[ -e $f ]] || continue

      # the ID you want to pass
      id="${gf}_had_${c}"

      args+=( "$f" "$id" )
    done
  done
done

# Check
if (( ${#args[@]} == 0 )); then
  echo "⚠️  No files found; nothing to do."
  exit 1
fi

echo "Running strip_hadspec_hdf5 on ${#args[@]}/2 files in one go…"
# Single invocation with all file+ID pairs
exec "$BIN" "${args[@]}"

