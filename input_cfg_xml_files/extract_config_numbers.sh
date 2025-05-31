#!/usr/bin/env bash

output="config_numbers.txt"

# clear or create the output file
> "$output"

# loop over all matching XMLs and extract the number
for f in input_cfg_*_GFlow.xml; do
  # remove leading “input_cfg_”, then cut off at the first “_”
  echo "${f#input_cfg_}" | cut -d_ -f1
done >> "$output"

echo "Saved all configuration numbers to $output"
