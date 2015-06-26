#!/bin/bash

alias m2srv='cd ~/.m2/repository && pyserve'


# Convenience function to install a maven artifact to the local repo
# Usage: mfinstall group.id:artifact.id:version[:packaging] fileToInstall
function mfinstall() {
  semicolons="${1//[^:]}"
  if [ "${#semicolons}" -lt 2 ]; then
    echo "Expected at least 2 semicolons in gav (\$1)"
    return 1
  fi
  if [ -z "$2" ]; then
    echo "Must specify file to install (\$2)"
    return 2
  fi
  IFS=':' read -a gav <<< "$1"
  mvn install:install-file -Dfile="$2" -DgroupId="${gav[0]}" -DartifactId="${gav[1]}" -Dversion="${gav[2]}" -Dpackaging="${gav[3]:-jar}"
}
