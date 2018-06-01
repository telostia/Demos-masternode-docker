#Create 1 docker container for demos daemon for master node
#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
apt -y -o Acquire::ForceIPv4=true update
apt-get -y -o "Dpkg::Options::=--force-confdef" -o "Dpkg::Options::=--force-confold" upgrade
apt -y install apt-transport-https ca-certificates curl software-properties-common git
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt -y -o Acquire::ForceIPv4=true update
apt -y install docker-ce
systemctl start docker
systemctl enable docker
docker pull ubuntu

ufw default allow outgoing
ufw default deny incoming
ufw allow ssh/tcp
ufw limit ssh/tcp
ufw allow 5005/tcp
#ufw allow 4141/tcp
ufw logging on
ufw --force enable

apt -y install fail2ban
systemctl enable fail2ban
systemctl start fail2ban

#build demos source git
apt install -y software-properties-common && add-apt-repository ppa:bitcoin/bitcoin && apt update && apt upgrade -y && apt install -y build-essential libtool autotools-dev automake pkg-config libssl-dev autoconf && apt install -y pkg-config libgmp3-dev libevent-dev bsdmainutils && apt install -y libevent-dev libboost-all-dev libdb4.8-dev libdb4.8++-dev nano git && apt install -y libminiupnpc-dev libzmq5 libdb-dev libdb++-dev unzip
cd /home
wget https://github.com/DemosPay/DemosPay/releases/download/v1.0/linux-binaries.tar.gz
tar xvzf linux-binaries.tar.gz 
chmod +x demosd && chmod +x demos-cli
mkdir -m755 ~/.demoscore


#building masternode
rm /home/Dockerfile
wget git remote add origin https://raw.githubusercontent.com/telostia/Demos-masternode-docker/master/demosmasternode/Dockerfile
docker build -t "demosmasternode" .

#SETUP WEB SERVER FOR MASTER NODE KEY
openssl req -new -x509 -days 365 -nodes -out /etc/ssl/certs/ssl-cert-snakeoil.pem -keyout /etc/ssl/private/ssl-cert-snakeoil.key -subj "/C=AB/ST=AB/L=AB/O=IT/CN=mastertoad"
apt-get -y install apache2 php libapache2-mod-php php-mcrypt inotify-tools pwgen
systemctl start apache2
a2ensite default-ssl 
a2enmod ssl 
systemctl restart apache2 
ufw allow 443/tcp

#DOWNLOAD WEBFORM AND SCRIPT
rm -rf /var/www/html/index.html
cd /var/www/html
wget https://raw.githubusercontent.com/telostia/Demos-masternode-docker/master/webscript/index.html
wget https://raw.githubusercontent.com/telostia/Demos-masternode-docker/master/webscript/masternode.php
mkdir /var/www/masternodeprivkey
touch /var/www/masternodeprivkey/masternodeprivkey.txt
chown -R www-data.www-data /var/www/masternodeprivkey
chown -R www-data.www-data /var/www/html
cd /root
wget https://raw.githubusercontent.com/telostia/Demos-masternode-docker/master/scripts/masterprivactivate.sh
chmod 755 /root/masterprivactivate.sh
/root/masterprivactivate.sh &
