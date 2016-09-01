#!/bin/bash

function fe() {
  if [ -z "$1" ]; then
    echo "Usage: fe [DIR_ARG] NAME_ARG"
    echo "    Runs a find command and then invokes \$EDITOR on the first line of the output."
  else
    if [ -z "$2" ]; then
      local NAME_ARG="$1"
      local DIR_ARG="./"
    else
      local NAME_ARG="$2"
      local DIR_ARG="$1"
    fi
    local FILE_TO_EDIT="$(find "$DIR_ARG" -name "$NAME_ARG" | head -n 1)"
    if [ -z "$FILE_TO_EDIT" ]; then
      echo "Unable to find file matching '$NAME_ARG' in dir '$DIR_ARG'"
    else
      if [ -z "$EDITOR" ]; then
        local EDITOR="vi"
      fi
      echo "$EDITOR" "$FILE_TO_EDIT"
      "$EDITOR" "$FILE_TO_EDIT"
    fi
  fi
}

function mcd() {
  if [ -z "$1" ]; then
    echo "Usage: mcd DIR_NAME"
    echo "    Creates a directory and cds into it"
  else
    mkdir "$1" && cd "$1"
  fi
}
