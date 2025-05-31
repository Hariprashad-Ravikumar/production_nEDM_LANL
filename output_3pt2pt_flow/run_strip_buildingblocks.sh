#!/usr/bin/env bash

cfg_list="/pscratch/sd/h/hari_8/production_nEDM_LANL/config_numbers.txt"
mapfile -t cfgs < <(awk '{print $NF}' "$cfg_list")

UDlabel=(U D)
GFlabel=(0p0 8p0 12p5 18p0)
tsrc=(8 12 14) 

for tsr in "${tsrc[@]}"; do
  for GF in "${GFlabel[@]}"; do
    for UD in "${UDlabel[@]}"; do
      for cfg in "${cfgs[@]}"; do
        input_file="WF${GF}_NUCL_${UD}_MIXED_NONREL3pt_t${tsr}_${cfg}.h5"
        output_file="FLOWED_${GF}_NUCL_${UD}_MIXED_NONREL.px0py0pz0.t0x0y0z0_t21x10y10z10_t42x20y20z20_HP_t${tsr}_${cfg}.bb"

        /pscratch/sd/h/hari_8/nEDM_project_LANL/chromaUtilsHDF5/bin/strip_buildingblocks_hdf5 \
          "$input_file" NUCL "$output_file" 001 --max-mom2=10 --max-link=1

        echo "Processed cfg ${cfg} with GF ${GF} and UD ${UD}"
      done
    done
  done
done

