#!/usr/bin/python

import os
import xml.etree.ElementTree as ET
import sys

def find_violations_file(rootDir, filename, fileFilter):
  tree = ET.parse(filename)
  results = []
  for parentFile in tree.getroot().iter('file'):
    errors = []
    relName = os.path.relpath(parentFile.get('name'), rootDir)
    if fileFilter is None or relName in fileFilter:
      for error in parentFile.iter('error'):
        errors.append({'line': error.get('line'), 'message': error.get('message'), 'column': error.get('column')})
      if len(errors) > 0:
        results.append({'filename': relName, 'errors': errors})
  return results

def find_violations_recursively(rootDir, fileFilter):
  results = []
  rootDir =  os.path.abspath(rootDir)
  for root, dirs, files in os.walk(rootDir):
    if 'checkstyle-result.xml' in files:
      filename = os.path.join(root, 'checkstyle-result.xml')
      results.extend(find_violations_file(rootDir, filename, fileFilter))
  return results

if __name__ == '__main__':
  fileFilter = None
  if len(sys.argv) > 1:
    fileList = [filename for filename in sys.argv[1:]]
    print('Searching for checkstyle errors in the following files: ')
    for fileName in fileList:
      print('  ' + str(fileName))
    fileFilter = set(fileList)
  for errorFile in find_violations_recursively(os.getcwd(), fileFilter):
    print(errorFile['filename'])
    for error in errorFile['errors']:
      print('  line: ' + str(error['line']) + ' column: ' + str(error['column']) + ' message: ' + str(error['message']))
    print('')
