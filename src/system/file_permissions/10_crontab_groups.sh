#!/usr/bin/env sh

PATH=/bin:/usr/bin

# start a subshell
output=$(
find /etc -maxdepth 1 -type f ! -group root -name crontab -printf "%p should be group-owned by root\n" 2>/dev/null
find /etc/cron.d -type f ! -group root -printf "%p should be group-owned by root\n" 2>/dev/null
find /etc/cron.daily -type f ! -group root -printf "%p should be group-owned by root\n" 2>/dev/null
find /etc/cron.hourly -type f ! -group root -printf "%p should be group-owned by root\n" 2>/dev/null
find /etc/cron.weekly -type f ! -group root -printf "%p should be group-owned by root\n" 2>/dev/null
find /var/spool/cron/ -type f ! -group root -printf "%p should be group-owned by root\n" 2>/dev/null
)

# we captured output of the subshell, let's interpret it
if [ "$output" == "" ] ; then
    exit $XCCDF_RESULT_PASS
else
    # print the reason why we are failing
    echo "$output"
    exit $XCCDF_RESULT_FAIL
fi

