#!/usr/bin/python

import os
import xml.etree.ElementTree as ET

def find_violations_file(rootDir, filename):
  tree = ET.parse(filename)
  results = []
  for parentFile in tree.getroot().iter('file'):
    errors = []
    for error in parentFile.iter('error'):
      errors.append({'line': error.get('line'), 'message': error.get('message'), 'column': error.get('column')})
    if len(errors) > 0:
      results.append({'filename': os.path.relpath(parentFile.get('name'), rootDir), 'errors': errors})
  return results

def find_violations_recursively(rootDir):
  results = []
  rootDir =  os.path.abspath(rootDir)
  for root, dirs, files in os.walk(rootDir):
    if 'checkstyle-result.xml' in files:
      filename = os.path.join(root, 'checkstyle-result.xml')
      results.extend(find_violations_file(rootDir, filename))
  return results

if __name__ == '__main__':
  for errorFile in find_violations_recursively(os.getcwd()):
    print(errorFile['filename'])
    for error in errorFile['errors']:
      print('  line: ' + error['line'] + ' column: ' + error['column'] + ' message: ' + error['message'])
    print('')
