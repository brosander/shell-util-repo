#!/usr/bin/python

import xml.etree.ElementTree as ET
import sys

if __name__ == '__main__':
  if len(sys.argv) != 2:
    raise Exception('Must specify ivy report file')
  tree = ET.parse(sys.argv[1])
  for module in  tree.getroot().iter('module'):
    groupId = module.get('organisation')
    artifactId = module.get('name')
    for revision in module.findall('revision'):
      version = revision.get('name')
      artifacts = revision.find('artifacts')
      for artifact in artifacts.findall('artifact'):
        print(':'.join([groupId, artifactId, version]) + ' ' + artifactId + '-' + version + '.' + artifact.get('type'))
