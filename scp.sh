#!/bin/bash

file=/home/ubuntu/tes-`date +"%Y%m%d"`.doc

echo "ubuntu" | scp $file ubuntu@192.168.60.130:/home/ubuntu/
