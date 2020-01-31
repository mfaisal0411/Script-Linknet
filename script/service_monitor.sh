#!/bin/bash

serv=apache2

sstat=$(pidof $serv | wc -l )

if [ $sstat -gt 0 ]

then

echo "$serv is running fine!!!"

else

echo "$serv is down/dead"

service $serv start

echo "$serv service is UP now!!!" | mail -s "$serv service is DOWN and restarted now On $(hostname)" mfaisal0411@gmail.com

fi
