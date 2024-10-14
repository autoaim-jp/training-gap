#! /bin/bash
# input
# $1: .mp4
# $2: .wav
# $3: output.mp4

# apad フィルターは、音声の後ろに無音をパディング（追加）
# -shortestオプションで動画の長さに合わせて出力
ffmpeg -i $1 -i $2 -filter_complex "[1:a]apad" -c:v copy -c:a aac -map 0:v:0 -map 1:a:0 -shortest -y ${3-output.mp4}

