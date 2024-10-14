#!/bin/bash

# sudo apt install xvfb

Xvfb :2 -screen 0 1920x1080x16 &
export DISPLAY=:2
# processing-java ...

