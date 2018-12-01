#!/usr/bin/env python

from __future__ import print_function
import os
import subprocess

print('PID\tSTAT\t\tCOMMAND')

dirs = os.listdir( '/proc' )
for pid in dirs:
    if not pid[0].isdigit():
        # Skip non-numeric dirs
        continue
    stat = subprocess.check_output('cat /proc/%s/status | grep State | cut -d: -f 2' % pid, shell = True).strip().decode('utf-8')
    with open('/proc/%s/cmdline' % pid) as f:
        command = f.read()
    if len(command) < 1:
        with open('/proc/%s/comm' % pid) as f:
            command = f.read().strip()
    print('%s\t%s\t%s\t' % (pid, stat, command))
