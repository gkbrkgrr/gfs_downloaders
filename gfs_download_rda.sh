#!/bin/bash

# Configuration
DATE="20200612" 
GFS_RUN="00" 
START_TIMESTEP="00"
END_TIMESTEP="06"
TIMESTEP="3"
SAVE_DIR="gfs_data"

mkdir -p "$SAVE_DIR"

opts="-qc"

v=$(wget -V | grep 'GNU Wget ' | cut -d ' ' -f 3)
a=$(echo $v | cut -d '.' -f 1)
b=$(echo $v | cut -d '.' -f 2)

if ((100 * a + b > 109)); then
  cert_opt="--no-check-certificate"
else
  cert_opt=""
fi

filelist=()

for (( timestep=START_TIMESTEP; timestep<=END_TIMESTEP; timestep+=TIMESTEP )); do
  TIMESTEP_PADDED=$(printf "%03d" "$timestep")  # Pad timestep with zeros (e.g., 000, 003, 006)
  url="https://data.rda.ucar.edu/d084001/2020/${DATE}/gfs.0p25.${DATE}${GFS_RUN}.f${TIMESTEP_PADDED}.grib2"
  filelist+=("$url")
done

echo "Generated URLs:"
printf "%s\n" "${filelist[@]}"

for url in "${filelist[@]}"; do
  syscmd="wget $cert_opt $opts -P \"$SAVE_DIR\" \"$url\""
  echo "$syscmd ..."
  eval "$syscmd"
done

echo "Download completed. Files saved in $SAVE_DIR/"

