#!/usr/bin/env bash

cfg_list="/pscratch/sd/h/hari_8/production_nEDM_LANL/config_numbers.txt"
mapfile -t cfgs < <(awk '{print $NF}' "$cfg_list")

UDlabel=(U)
GFlabel=(0p0 8p0 12p5 18p0)

for UD in "${UDlabel[@]}"; do
  for GF in "${GFlabel[@]}"; do
    for cfg in "${cfgs[@]}"; do
      output_file="WF${GF}_pion3pt_t10_${cfg}.h5"
      input_file="FLOWED_${GF}_pion.px0py0pz0.t0x0y0z0_t21x10y10z10_t42x20y20z20_HP_t10_${cfg}.bb"

      /pscratch/sd/h/hari_8/nEDM_project_LANL/chromaUtilsHDF5/bin/strip_buildingblocks_hdf5 \
        "$output_file" NUCL "$input_file" 001 --max-mom2=10 --max-link=1

      echo "Processed cfg ${cfg} with GF ${GF} and UD ${UD}"
    done
  done
done

