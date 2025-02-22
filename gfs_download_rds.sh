DOWNLOAD_DIR="gfs_data" # Which directory that gfs files are going to be saved
DATE="20201206" # Date of the gfs files that whished to be downloaded in Ymd format.
RUN="00" # Which gfs run
START_TIMESTEP="00" # Timestep of the first gfs file 
END_TIMESTEP="72" # Timestep of the last gfs file 
TIMESTEP="3" 

BASE_URL="https://data.rda.ucar.edu/ds084.1"

mkdir -p "$DOWNLOAD_DIR"

for i in $(seq $START_TIMESTEP $TIMESTEP $END_TIMESTEP); do
    FILE_NAME="gfs.0p25.${DATE}${RUN}.f$(printf "%03d" $i).grib2"
    URL="${BASE_URL}/${DATE}/${RUN}/atmos/${FILE_NAME}"

    echo "Downloading: $URL"
    wget -P "$DOWNLOAD_DIR" "$URL" -qc
done
