#!/bin/bash

# Shorthand for git status -s
alias gss='git status -s'

# Pushes current branch to origin
alias gpo='git status | grep "On branch " | awk "{print \$NF}" | xargs git push origin'

# Checks out master, merges in upstream/master, and pushes to origin
alias gum='git checkout master && git fetch upstream && git merge upstream/master && git push origin master'
alias guf='git checkout future-develop && git fetch upstream && git merge upstream/future-develop && git push origin future-develop'

# Shows all files that match gss grep
function gsg {
  gss | grep "$1" | awk '{print $NF}'
}

# Runs git command on all files from gsg
function gbc {
  gsg "$1" | xargs git "$2"
}

function gstat {
  if [ -z "$1" ]; then
    COMMIT="HEAD~1"
  else
    COMMIT="$1"
  fi
  git diff --name-only --relative "$COMMIT"
}
