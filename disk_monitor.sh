#!/bin/sh
df -Ph | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5,$1 }'  | while read output;
do
  echo $output
  penggunaan=$(echo $output | awk '{print $1}' | sed s/%//g)
  partisi=$(echo $output | awk '{print $2}')
  if [ $penggunaan -ge 20 ]; then
  echo "Partisi \"$partisi\" di $(hostname) sudah mencapai $penggunaan% pada $(date)" | mailx -s "Disk Space Alert: $penggunaan% Used On $(hostname)" faisal@paques.id mfaisal0411@gmail.com
  fi
done
