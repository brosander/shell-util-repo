#!/bin/bash

if [ "$(basename "$SHELL")" = "bash" ]; then
  export PATH="$PATH:`dirname ${BASH_SOURCE[0]}`/python"
else
  export PATH="$PATH:$(dirname "$0")/python"
fi

prcheck() {
  if [ -z "$1" ]; then
    COMMIT="HEAD~1"
  else
    COMMIT="$1"
  fi
  git diff --name-only --relative "$COMMIT" | tr '\n' '\0' | xargs -0 checkstyle.py
}

alias pyserve='python -m SimpleHTTPServer'
