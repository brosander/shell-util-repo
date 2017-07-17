function mfcat() {
  unzip -p "$1" META-INF/MANIFEST.MF | perl -0777 -wpe 's/\r?\n //g'
}

if [ "$(basename "$SHELL")" = "bash" ]; then
  export PATH="$PATH:`dirname ${BASH_SOURCE[0]}`/java/build/jregex/jregex/bin"
else
  export PATH="$PATH:$(dirname "$0")/java/build/jregex/jregex/bin"
fi
