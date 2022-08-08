#!/bin/bash

# install FFMpeg & Gifski
# brew install ffmpeg gifski

tool_chk() {
  local tool="${1}"

  if ! which "${tool}"; then
    brew install "${tool}"
  fi
}

gif() {
  local gifdir="$TMPDIR/gif"
  rm -rf "${gifdir}"
  mkdir -p "${gifdir}"

  ffmpeg -i "${1}" -r 10 -filter:v "setpts=0.5*PTS" "${gifdir}"/frame%04d.png
  gifski -o output.gif "${gifdir}"/frame*.png
}

tool_chk ffmpeg

tool_chk gifski

gif "${1}"
