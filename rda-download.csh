#!/bin/bash

opts="-N"
v=$(wget -V | grep 'GNU Wget ' | cut -d ' ' -f 3)
a=$(echo $v | cut -d '.' -f 1)
b=$(echo $v | cut -d '.' -f 2)

if ((100 * a + b > 109)); then
  cert_opt="--no-check-certificate"
else
  cert_opt=""
fi

filelist=(
  "https://data.rda.ucar.edu/d084001/2020/20200612/gfs.0p25.2020061200.f000.grib2"
  "https://data.rda.ucar.edu/d084001/2020/20200612/gfs.0p25.2020061200.f003.grib2"
  "https://data.rda.ucar.edu/d084001/2020/20200612/gfs.0p25.2020061200.f006.grib2"
  "https://data.rda.ucar.edu/d084001/2020/20200612/gfs.0p25.2020061200.f009.grib2"
)

for url in "${filelist[@]}"; do
  syscmd="wget $cert_opt $opts $url"
  echo "$syscmd ..."
  eval "$syscmd"
done

