#!/usr/bin/python

import fileinput

if __name__ == '__main__':
  for line in fileinput.input():
    gav = line.strip().split(':')
    print('<dependency>')
    print('  <groupId>' + gav[0] + '</groupId>')
    print('  <artifactId>' + gav[1] + '</artifactId>')
    print('  <version>' + gav[2] + '</version>')
    print('</dependency>')
