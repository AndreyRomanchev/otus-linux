#!/usr/bin/env python
import signal
import sys

def signal_ctrlc(sig, frame):
    print('You pressed Ctrl+C!')

def signal_ctrlz(sig, frame):
    print('You pressed Ctrl+Z!')

def signal_term(sig, frame):
    print('You tried to kill me?!')

signal.signal(signal.SIGINT, signal_ctrlc)
signal.signal(signal.SIGTSTP, signal_ctrlz)
signal.signal(signal.SIGTERM, signal_term)

while True:
    print('use kill -9 to quit')
    signal.pause()
