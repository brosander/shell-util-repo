#!/usr/bin/python

import fileinput

if __name__ == '__main__':
  for line in fileinput.input():
    gav = line.strip().split(':')
    print('<include>' + gav[0] + ':' + gav[1] + '</include>')
