#!/bin/bash

logfile=nice.log
:> $logfile


function nice19()
{
    echo $(date) " Start function with nice19" >> $logfile
    nice -19 tar -czf /tmp/nice19.tar.gz /boot /usr >/dev/null 2>&1
    echo $(date) " End function with nice19" >> $logfile
}

function nice_20()
{
    echo $(date) " Start function with nice-20" >> $logfile
    nice --20 tar -czf /tmp/nice-20.tar.gz /boot /usr >/dev/null 2>&1
    echo $(date) " End function with nice-20" >> $logfile
}

(nice19) &
(nice_20) &
