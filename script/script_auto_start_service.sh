#!/bin/bash

name_service=paques.builds.js
serv=$(ps -ef|grep node|grep paques.builds.js|wc -l )

if [ $serv -gt 0 ]

then

echo "$name_service is running fine!!!"

else

echo "$name_service is down/dead"

./start.sh -b

echo "$name_service service is UP now!!!" | mail -s "$name_service service is DOWN and restarted now On $(hostname)" mfaisal0411@gmail.com

fi
