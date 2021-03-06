#!/bin/bash

echo '>>> Get old container id'

CID=$(sudo docker ps | grep "iam" | awk '{print $1}')
echo $CID

sudo touch iam-build.log

sudo docker build -t iam . | tee iam-build.log

RESULT=$(cat iam-build.log | tail -n 1)
if [["$RESULT" != *Successfully*]];then
  exit -1
fi
 
if [ "$CID" != "" ];then
  echo '>>> Stop and remove old container'
  sudo docker stop $CID
  sudo docker rm $CID
fi

echo '>>> Starting new container'
sudo docker run -d -p 10040:8080 -e dataSource.driverClassName=org.gjt.mm.mysql.Driver -e dataSource.url=jdbc:mysql://10.0.7.107:3306/iam?useUnicode=true&characterEncoding=UTF-8 -e dataSource.username=root -e dataSource.password=root iam
