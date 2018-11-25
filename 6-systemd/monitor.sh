#!/bin/bash

output=$(grep -i $KEYWORD $LOGFILE)
if [ -n $output ]; then
    echo "Got $KEYWORD in an $LOGFILE" | mail -s "Monitor alert" admin@example.com
fi
