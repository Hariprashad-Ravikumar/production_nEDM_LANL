for xml in input_gg_cfg_*_GFlow.xml; do
  sbatch run_chroma.sh "$xml"
done

