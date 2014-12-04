#!/bin/bash

# Shorthand for git status -s
alias gss='git status -s'

# Pushes current branch to origin
alias gpo='git status | grep "On branch " | awk "{print \$NF}" | xargs git push origin'

# Checks out master, merges in upstream/master, and pushes to origin
alias gum='git checkout master && git fetch upstream && git merge upstream/master && git push origin master'

# Shows all files that match gss grep
function gsg {
  gss | grep "$1" | awk '{print $NF}'
}

# Runs git command on all files from gsg
function gbc {
  gsg "$1" | xargs git "$2"
}
