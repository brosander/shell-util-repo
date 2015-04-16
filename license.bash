#!/bin/bash

# This function will add the license header in file $1 to every java file
function addLicenseJava {
  echo "addLicense \"$1\""
  find . -name '*.java' -type f -print0 | xargs -0 -I {} bash -c "source ~/.bashrc && addLicenseJavaIndividual '$1' '{}'"
}

function addLicenseTopExtension {
  echo "addLicenseJS \"$1\""
  find . -name "*.$2" -type f -print0 | xargs -0 -I {} bash -c "source ~/.bashrc && addLicenseTopOfFile '$1' '{}'"
}

# This function will add the license header in file $1 to file $2
function addLicenseJavaIndividual {
  echo "addLicenseJavaIndividual \"$1\" \"$2\""
  local tmpFile=$(mktemp)
  local packageLineNo="`grep -n '^package ' \"$2\" | sed 's/^\([0-9]\+\).*$/\1/g'`"
  local tailCommand="tail -n+$packageLineNo \"$2\" >> \"$tmpFile\""
  #echo "$tailCommand"
  cat "$1" > "$tmpFile" && eval "$tailCommand" && mv "$tmpFile" "$2"
}

function addLicenseTopOfFile {
  echo "addLicenseTopOfFile \"$1\" \"$2\""
  local tmpFile=$(mktemp)
  cat "$1" > "$tmpFile" && cat "$2" >> "$tmpFile" && mv "$tmpFile" "$2"
}
