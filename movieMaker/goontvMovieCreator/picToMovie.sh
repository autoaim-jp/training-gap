#! /bin/bash

cat ${1-tmp}/* | ffmpeg -framerate 60 -f image2pipe -i - $(date '+%Y%m%d_%H%M').mp4
