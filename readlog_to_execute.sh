#!/bin/bash
tail -fn0 /path_log |\
while read line; do
      echo "$line" | grep "PATTERN"
      if [ $? = 0 ]
      then
      ......do something......
      fi
done
