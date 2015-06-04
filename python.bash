#!/bin/bash

export PATH="$PATH:`dirname ${BASH_SOURCE[0]}`/python"

prcheck() {
  if [ -z "$1" ]; then
    COMMIT="HEAD~1"
  else
    COMMIT="$1"
  fi
  git diff --stat=10000 --relative "$COMMIT" | head -n-1 | awk '{print $1}' | xargs checkstyle.py
}
