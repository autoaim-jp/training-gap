#! /bin/bash

rm result/sample1/*.jpg
SKETCH=`basename $(pwd)`
env ANIMATION_JSON_FILE_PATH='news2.json' MOVIE_OUTPUT_DIR='./result/sample1/' ~/application/processing-3.5.4/processing-java --sketch=../$SKETCH --output=build --force --run 
cat result/sample1/* | ffmpeg -framerate 15 -f image2pipe -i - $(date '+%Y%m%d_%H%M').mp4

