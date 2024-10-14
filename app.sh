#!/bin/bash

# first, run startVirtualDisplay.sh
# ./startVirtualDisplay.sh

TIME_JSON_FILE=./result/20241010/src/1_timejson/time_ver1.json
JSON_FILE=./result/20241010/adjusted/__animation.json
TMP_DIR=./result/20241010/tmp/
MOVIE_ONLY_FILE=./result/20241010/adjusted/__concat.mp4
WAV_ONLY_FILE=./result/20241010/adjusted/__concat.wav
RESULT_FILE_NAME=$(date '+%Y%m%d_%H%M%S').mp4
RESULT_FILE=./result/20241010/output/$RESULT_FILE_NAME

rm -rf ${TMP_DIR}/*

sox \
  ./voiceMaker/se/shop-chime1-6s.wav \
  ../voicepeak-result/voicepeak3/0-voicepeak_proj1.wav \
  ./voiceMaker/se/decision17_gain.wav \
  ../voicepeak-result/voicepeak3/1-voicepeak_proj1.wav \
  ./voiceMaker/se/decision17_gain.wav \
  ../voicepeak-result/voicepeak3/2-voicepeak_proj1.wav \
  ./voiceMaker/se/decision17_gain.wav \
  ../voicepeak-result/voicepeak3/3-voicepeak_proj1.wav \
  ./voiceMaker/se/decision17_gain.wav \
  ../voicepeak-result/voicepeak3/4-voicepeak_proj1.wav \
  ./voiceMaker/se/decision17_gain.wav \
  ../voicepeak-result/voicepeak3/5-voicepeak_proj1.wav \
  ./voiceMaker/se/decision17_gain.wav \
  ../voicepeak-result/voicepeak3/6-voicepeak_proj1.wav \
  ./voiceMaker/se/muon1.wav \
  ../voicepeak-result/voicepeak3/7-voicepeak_proj1.wav \
  $WAV_ONLY_FILE

# aplay $WAV_ONLY_FILE

node voiceMaker/generateAnimationJson.js $TIME_JSON_FILE

./movieMaker/bash/generateMovieByProcessing.sh $JSON_FILE $TMP_DIR $MOVIE_ONLY_FILE

./movieMaker/bash/concat.sh $MOVIE_ONLY_FILE $WAV_ONLY_FILE $RESULT_FILE

echo "xdg-open $RESULT_FILE"

