#!/bin/bash

logfile=ionice.log
:> $logfile


function ionice3()
{
    echo $(date) " Start function with ionice3" >> $logfile
    ionice -c 3 bash -c "dd if=/dev/urandom of=ionice-3.log bs=1M count=2500 && rm ionice-3.log"
    echo $(date) " End function with ionice3" >> $logfile
}

function ionice1()
{
    echo $(date) " Start function with ionice1" >> $logfile
    ionice -c 1 -n 0 bash -c "dd if=/dev/urandom of=ionice-1.log bs=1M count=2500 && rm ionice-1.log"
    echo $(date) " End function with ionice1" >> $logfile
}

(ionice3) &
(ionice1) &
