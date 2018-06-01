#!/bin/bash
while inotifywait -e modify /var/www/masternodeprivkey/masternodeprivkey.txt; do
  IP=$(curl ipinfo.io/ip)
  USERNAME=$(pwgen -s 16 1)
  PASSWORD=$(pwgen -s 64 1)
  MASTERNODEPRIVKEY=$(</var/www/masternodeprivkey/masternodeprivkey.txt)
  echo "rpcuser=$USERNAME" >/home/demos.conf
  echo "rpcpassword=$PASSWORD" >>/home/demos.conf
  echo "server=1" >>/home/demos.conf
  echo "listen=1" >>/home/demos.conf
  echo "port=5005" >>/home/demos.conf
  echo "rpcallowip=127.0.0.1" >>/home/demos.conf
  echo "addnode=18.188.99.190" >>/home/demos.conf
  echo "addnode=18.188.220.201" >>/home/demos.conf
  echo "addnode=13.59.221.246" >>/home/demos.conf
  echo "addnode=52.15.63.29" >>/home/demos.conf
  echo "maxconnections=16" >>/home/demos.conf
  echo "masternodeprivkey=$MASTERNODEPRIVKEY" >>/home/demos.conf
  echo "masternode=1" >>/home/demos.conf
  echo "externalip=$IP:5005" >>/home/demos.conf
  #docker stop demosmasternode
  docker run -d --name demosmasternode demosmasternode
  docker cp /home/demos.conf demosmasternode:/root/.demoscore/
  docker cp /home/demosd demosmasternode:/home/
  docker commit demosmasternode demosmasternode
  docker container rm demosmasternode
  echo 'loading master node...'
  docker run -d --restart always -p 5005:5005 --name demosmasternode demosmasternode /home/demosd -datadir=/root/.demoscore -conf=/root/.demoscore/demos.conf
  #docker stop demosmasternode
  docker start demosmasternode
  systemctl stop apache2
  systemctl disable apache2
  ufw delete allow 443/tcp
  break 
done
