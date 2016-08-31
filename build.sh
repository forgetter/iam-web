#!/bin/bash

echo '>>> Get old container id' > iam-build.log

CID=$(sudo docker ps | grep "iam" | awk '{print $1}')
echo $CID >> iam-build.log

sudo docker build -t iam . | tee iam-build.log
 
RESULT=$(cat iam-build.log | tail -n 1)
#if ["$RESULT" != *Successfully*];then
#  exit -1
#fi
 
if [ "$CID" != "" ];then
  echo '>>> Stop and remove old container' >> iam-build.log
  sudo docker stop $CID >> iam-build.log
  sudo docker rm $CID >> iam-build.log
fi

echo '>>> Starting new container' >> iam-build.log
sudo docker run -d -p 10040:8080 iam >> iam-build.log
