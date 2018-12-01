#!/usr/bin/env python

from __future__ import print_function
import sys
import os
import subprocess
import psutil

filetolook = sys.argv[1]

dirs = os.listdir( '/proc' )
for pid in dirs:
    if not pid[0].isdigit():
        # Skip non-numeric dirs
        continue
    with open('/proc/%s/comm' % pid) as f:
        command = f.read().strip()
    p = psutil.Process(int(pid))
    openfiles = p.open_files()
    for file in openfiles:
        path = file[0]
        if filetolook in path:
            print('%s\t%s\t%s' % (pid, command, filetolook))
