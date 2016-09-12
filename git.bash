#!/bin/bash

# Shorthand for git status -s
alias gss='git status -s'

# Pushes current branch to origin
alias gpo='git status | grep "On branch " | awk "{print \$NF}" | xargs git push origin'

# Checks out master, merges in upstream/master, and pushes to origin
alias gum='gu master'
alias guf='gu future-develop'

function gu () {
  if [ -z "$1" ]; then
    echo "Usage gu BRANCH_NAME"
    echo "    Checks out fetches upstream, merges, pushes to origin."
  else
    git checkout "$1" && git fetch upstream "$1" && git merge upstream/"$1" && git push origin "$1"
  fi
}

function gpr() {
  if [ -z "$1" ]; then
    echo "PR number required as \$1"
  else
    git fetch upstream pull/"$1"/head:pr"$1" && git checkout pr"$1"
  fi
}

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

function gh-clone {
  if [ -z "$1" ]; then
    echo "Repo name required"
  else
    if [ -z "$2" ]; then
      PARENT="pentaho"
    else
      PARENT="$2"
    fi
    cd ~/github
    git clone git@github.com:"$GITHUB_USER_NAME"/"$1".git \
      && cd "$1" \
      && git remote add upstream git@github.com:"$PARENT"/"$1".git
  fi
}
