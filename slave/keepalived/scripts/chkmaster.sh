#!/bin/bash
STATUS=`/usr/local/bin/redis-cli info | grep role:master | wc -l`
echo $STATUS
if [ "$STATUS" -eq 0 ]; then
     exit 1
else
     exit 0
fi
