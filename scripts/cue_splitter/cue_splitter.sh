#!/bin/bash

print_usage() {
  echo "Usage: $1 --cue <file.cue> --flac <file.flac>"
}

## Usage <script> <cue_file> <flac file>
while [ -n "$1" ]; do
  case "$1" in
    --flac)
      # TODO: test for the existence of an aditional parameter
      FLAC_FILE="$2"
      shift
      ;;
    --cue)
      # TODO same as above
      CUE_FILE="$2"
      shift
      ;;
    *)
      echo "Unexpected option $1"
      ;;
  esac

  # shift arguments so that $1 becomes $2, and so on, without changing $0 (script name)
  shift
done

# TODO: test if FLAC_FILE and CUE_FILE are defined

if [ -z ${FLAC_FILE+x} ]; then
  echo "Missing flac file path"
  print_usage
  exit 1
fi

if [ -z ${CUE_FILE+x} ]; then
  echo "Missing cue file path"
  print_usage
  exit 2
fi

# create a directory to store the individual track files
# TODO: Perhaps this should be an optional parameter?
# TODO: What if the directory already exists?
mkdir -p tracks

# split the original file based on the provided .cue file
# each file is named as: <track no> - <track title>
# each track audio file is stored in tracks/ directory
# TODO: the '-o' option is hardcoded for FLAC files. I might need support for other files in the future. See https://linux.die.net/man/1/shntool
shntool split -f "$CUE_FILE" -t '%n - %t' -o flac -d tracks/ -- "$FLAC_FILE"