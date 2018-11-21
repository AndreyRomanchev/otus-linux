#!/bin/bash

# Number of IPs to return
X=5
# Number of paths to return
Y=5
access_log="access.log"
error_log="error.log"

lockfile=/var/tmp/mail_errors.lock
lastrunfile=/var/tmp/mail_errors.run

if [ -f $lockfile ]; then
    echo "${0} is already running"
    exit 1
fi

touch $lockfile
trap "rm -f $lockfile; exit $?" INT TERM EXIT

last_log_date=$(tail -n 1 access.log | sed -r 's/.* \[.*\/(.*) \+0300\] .*/\1/')
if [ -s $lastrunfile ]; then
    previous_run_date=$(cat $lastrunfile)
else
    previous_run_date='.*'
fi

mailbody="Most common IPs from the time of last run\n"
mailbody=$mailbody$(sed -n "/$previous_run_date/,\$p" $access_log | awk '{print $1}' | sort | uniq -c | sort -nr | head -n $X)

mailbody="$mailbody\n\nMost common paths from the time of last run\n"
mailbody=$mailbody$(sed -n "/$previous_run_date/,\$p" $access_log | sed -r 's/.*"(GET|POST) (.*) HTTP\/[[:digit:]].[[:digit:]]".*/\2/' | sort | uniq -c | sort -nr | head -n $Y)

mailbody="$mailbody\n\nAll errors from the time of last run\n"
mailbody=$mailbody$(sed -n "/$previous_run_date/,\$p" $error_log)

mailbody="$mailbody\n\nAll exit codes from the time of last run\n"
mailbody=$mailbody$(sed -n "/$previous_run_date/,\$p" $access_log | sed -r 's/.*" ([0-9]{3}) .*/\1/' | sort | uniq -c | sort -nr)

rm -f $lockfile
echo $last_log_date > $lastrunfile

printf $mailbody | mail -s "Log stats from $previous_run_date to $last_log_date" admin@example.com
trap - INT TERM EXIT
