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
  local mov_file="${1}"
  output_file="$(echo "${mov_file}" | awk -F. '{print $1}')"

  rm -rf "${gifdir}"
  mkdir -p "${gifdir}"

  ffmpeg -i "${mov_file}" -r 10 -filter:v "setpts=0.5*PTS" "${gifdir}"/frame%04d.png
  gifski -o "${output_file}.gif" "${gifdir}"/frame*.png
}

tool_chk ffmpeg

tool_chk gifski

gif "${1}"
