function mfcat() {
  unzip -p "$1" META-INF/MANIFEST.MF | perl -0777 -wpe 's/\r?\n //g'
}
