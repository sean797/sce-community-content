#!/usr/bin/env sh

ACCESS=$(stat -c '%a' /etc/shadow)

if [ $ACCESS -ne 0400 ]
then
  echo "/etc/shadow should have its permissions set to 0400 instead of 0$ACCESS"
  exit $XCCDF_RESULT_FAIL
fi

exit $XCCDF_RESULT_PASS
