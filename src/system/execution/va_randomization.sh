#!/usr/bin/env bash

VA_RANDOMIZATION=1

if [ ! -f /proc/sys/kernel/randomize_va_space ]
then
  echo 'WARNING: va randomization not found'
  exit $XCCDF_RESULT_NOT_APPLICABLE
fi

RET=$XCCDF_RESULT_PASS

# Check sysctl configuration file(s)
for config in $(ls -1 /etc/sysctl.conf /etc/sysctl.d/* 2>/dev/null)
do
  grep -q kernel.randomize_va_space $config || continue

  SETTING=$(cat $config | grep kernel.randomize_va_space | sed -e 's,[^#= ]\+\s*=\s*\([^#]\+\),\1,g')

  if [ $SETTING -ne $VA_RANDOMIZATION ]
  then
    echo "va randomization is disabled in $config"
    RET=$XCCDF_RESULT_FAIL
  fi
done

exit $RET
