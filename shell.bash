#!/bin/bash

DIR_ALIASES=~/.shell_util_dir_aliases

if [ ! -d "$DIR_ALIASES" ]; then
  mkdir "$DIR_ALIASES"
fi

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

function l() {
  if [ -z "$1" ]; then
    echo "Usage: l ALIAS"
    echo "    cds into the directory stored with this alias"
  else
    local ALIAS_FILE="$DIR_ALIASES/$(basename "$1")"
    if [ -f "$ALIAS_FILE" ]; then
      cd "$(cat "$ALIAS_FILE")"
    else
      echo "l: alias '$1' undefined"
    fi
  fi
}

function s() {
  if [ -z "$1" ]; then
    echo "Usage: s ALIAS"
    echo "    stores the current directory as the specified alias"
  else
    local ALIAS_FILE="$DIR_ALIASES/$(basename "$1")"
    pwd > "$ALIAS_FILE"
  fi
}

function d() {
  if [ -z "$1" ]; then
    echo "Usage: d ALIAS"
    echo "    deletes the specified directory alias"
  else
    local ALIAS_FILE="$DIR_ALIASES/$(basename "$1")"
    rm -f "$ALIAS_FILE"
  fi
}

function p() {
  if [ -z "$1" ]; then
    find "$DIR_ALIASES" -maxdepth 1 -type f -print0 | xargs -0 -I {} bash -c 'echo "$(basename "$0"): $(cat "$0")"' {} | sort
  else
    local ALIAS_FILE="$DIR_ALIASES/$(basename "$1")"
    if [ -f "$ALIAS_FILE" ]; then
      echo "$1: $(cat "$ALIAS_FILE")"
    else
      echo "$1: undefined"
    fi
  fi
}
