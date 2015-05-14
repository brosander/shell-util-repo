#!/usr/bin/python

import os
from operator import itemgetter
import xml.etree.ElementTree as ET

def find_coverage_file(rootDir, filename):
  tree = ET.parse(filename)
  results = []
  for clazz in tree.getroot().iter('class'):
    clazzMetrics = { 'name': clazz.get('name'), 'hits': 0, 'misses' : 0 }
    for lines in clazz.findall('lines'):
      for line in lines.findall('line'):
        if str(line.get('hits')) == '0':
          clazzMetrics['misses'] += 1
        else:
          clazzMetrics['hits'] += 1
    results.append(clazzMetrics)
  return results

def find_coverage_recursively(rootDir):
  results = []
  rootDir =  os.path.abspath(rootDir)
  for root, dirs, files in os.walk(rootDir):
    if 'coverage.xml' in files:
      filename = os.path.join(root, 'coverage.xml')
      results.extend(find_coverage_file(rootDir, filename))
  return results

if __name__ == '__main__':
  coverage = find_coverage_recursively(os.getcwd())
  for clazz in sorted(coverage, key=itemgetter('misses')):
    print(clazz['name'] + ' : misses: ' + str(clazz['misses']))
