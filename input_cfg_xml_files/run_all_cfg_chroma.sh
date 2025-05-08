for xml in input_cfg_*_GFlow.xml; do
  sbatch run_chroma.sh "$xml"
done

