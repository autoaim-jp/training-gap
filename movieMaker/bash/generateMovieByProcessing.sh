#! /bin/bash

TMP_DIR=$(date '+%Y%m%d_%H%M%S')
mkdir -p /tmp/__mediaCreator/$TMP_DIR

# first, run startVirtualDisplay.sh
# Xvfb :2 -screen 0 1920x1080x16 &
export DISPLAY=:2

env ANIMATION_JSON_FILE_PATH=${1} MOVIE_OUTPUT_DIR=/tmp/__mediaCreator/$TMP_DIR/ THUBMNAIL_OUTPUT_DIR=${2} ~/application/processing-3.5.4/processing-java --sketch=./movieMaker/goontvMovieCreator --output=build --force --run 

rm ${3}

cat /tmp/__mediaCreator/$TMP_DIR/* | ffmpeg -framerate 16.5 -f image2pipe -i - ${3}
# ffmpeg -framerate 16.5 -i /tmp/__mediaCreator/20241011_134632/frame_%7d.jpg -c:v libx264 -pix_fmt yuv420p output.mp4

echo "[debug]"
# rm -rf /tmp/__mediaCreator/$TMP_DIR
echo  /tmp/__mediaCreator/$TMP_DIR

