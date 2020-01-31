#!/bin/bash
tail -fn0 /var/log/mail.log|\
while read line; do
	echo "$line" | grep "connect from localhost"
	if [ $? = 0 ]
	then 
	echo "Error found on $HOSTNAME" | mailx -s "Something's wrong on $(hostname)" mfaisal0411@gmail.com
fi
done 
