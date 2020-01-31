#!/bin/sh
rm /home/ubuntu/partisi.txt
echo "\n\n==================================== DISK PARTATION INFO =====================================\n" >> /home/ubuntu/partisi.txt
df -h >> /home/ubuntu/partisi.txt
echo "\n\n==============================================================================================\n" >> /home/ubuntu/partisi.txt
total=$(cat /home/ubuntu/partisi.txt)
df -Ph | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5,$1 }'  | while read output;
do
  echo $output
  penggunaan=$(echo $output | awk '{print $1}' | sed s/%//g)
  partisi=$(echo $output | awk '{print $2}')
  if [ $penggunaan -ge 20 ]; then
  echo "Partisi \"$partisi\" di $(hostname) sudah mencapai $penggunaan% pada $(date) \n $total \n\n\n PAQUES 2020" | mailx -s "Disk Space Alert: $penggunaan% Used On $(hostname)" faisal@paques.id mfaisal0411@gmail.com
  fi
done
