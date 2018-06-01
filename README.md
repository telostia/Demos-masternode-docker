# fork and credits go to CryptoHawaii Pepe/Meme Coin Docker 
# original github: https://github.com/CryptoHawaii-com/pepecoin-Dockerfiles
# Modified to work with Demospay (demos) coin.

### Details:
Demospay Master Node - Ideally this is run on 2 CPU(s).

What the script does: 

Installs docker and builds 2 docker containters, 1 master node containter, 1 seed node containter.  Provides a TEMP website for you to enter your Master Node Priv Key.  Once you enter your Master Node Priv Key, web server is shutdown and master node is started. Read full Installation Instructions below.


This will create (1) master node and (1) seed node: 

2. Masternode on port 5005

*all rewards goto you for helping out with the seeding. 

##[[
	original youtube from peepcoin with same concept
	https://www.youtube.com/watch?v=yOjFrc1UXTc&feature=youtu.be
##]]
What you need to do (general overview):

1. Wallet - create master node - IP of your node:5005 
2. Fund the received address with 1,000 coins (it may or may not charge you) it'll be live after 15 confirmations. 
  - Send EXACTLY 1,000 coins - otherwise you will get errors. (our video walk through was wrong to send 1,010 coins)
3. Get config and input in the 1-time entry URL @ the IP of your server
   - After you input the key the website will never work again (if you make a mistake you'll have to reinstall)
4. Click on your MN to start receiving payments.

### Installation Instructions:

Required: Fresh install Ubuntu 16.04

ssh to server and run

Install withOUT SWAP
```
bash -c "$(wget -O - https://raw.githubusercontent.com/telostia/Demos-masternode-docker/master/install.sh)"
```

Install with SWAP
```
bash -c "$(wget -O - https://raw.githubusercontent.com/telostia/Demos-masternode-docker/master/createswap.sh)" && bash -c "$(wget -O - https://raw.githubusercontent.com/telostia/Demos-masternode-docker/master/install.sh)"
```

Installation time takes approx 20 minutes, demosd will be compiled from the latest git pull, this part can be slow.
Once the installation is completed you will have 1 running docker container. The name of the container is "solarium"

You must now activate your master node or manually stop the webserver.

Activating your master node is very simple. 
When generating your masternodeprivkey configuration you will need the following details:
We will be using port 5005 for the master node.

***serverip = your.server.ip.address***

***serverport = 5005***

Browse to your servers ip address with https://

`https://your.server.ip.address`

You will be prompted to accept the self signed cert and proceed.

Enter your masternodeprivkey exactly as your wallet outputs. *For more information on the wallet setup [http://cryptohawaii.com/memetic-masternode/](http://cryptohawaii.com/memetic-masternode/)*

Once you enter and submit your masternodeprivkey, your masternode docker container will start and the URL will destroyed. This means if you have entered the masternodeprivkey incorrectly, you will need to rebuild the entire node from scratch (start over).

check that both containers are now running

`docker ps`

output will look similar to this:
```
ca1e93f6e569        demosmasternode   "/home/demosd"   21 minutes ago      Restarting (127) 52 seconds ago                       demos
```
*OPTIONAL: If you are not a master node STOP the webserver*

If you are not hosting a master node, you need to stop the webserver to secure the system.
ssh into your server and execute the following 2 commands.

`systemctl stop apache2`

and then

`systemctl disable apache2`

We hope you choose to run a master node.


### Command Line Usage

The following commands assume you have basic linux knowledge and have an ssh connection already established to your server. 
There are 1 docker containers running: *demosmasternode*

**List running containers**

`docker ps`

**To enter a container**

`docker exec -it CONTAINERNAME bash`

where CONTAINERNAME is `demosmasternode` or `solmn` (i.e. `docker exec -it solmn bash`)

you will see a new root prompt once in the container 
example output:
```
root@localhost:~# docker exec -it demosmasternode bash
root@f93f055fd7d7:/#
```

**demosd commands in container**

Execute demosd commands within a container like this

`/home/demosd COMMAND`

for example

`/home/demos-cli getinfo`

or to check status

`/home/demos-cli masternode status`

All files are located in /root/.demoscore on each node
demos.conf is located /root/.demoscore/demos.conf

If you found this helpful don't be shy to donate:

demos : D6PtAVssa35rZ471xSjd1skM7h5Y3zZj3N

BTC : 

LTC : 

ETH : 


and ofcourse 
thanks go:
-to the original script at: https://github.com/CryptoHawaii-com/pepecoin-Dockerfiles
-https://github.com/kwiksand. This container uses the cryptocoin-base container (https://quay.io/repository/kwiksand/cryptocoin-base) which installs ubuntu and all the bitcoin build dependencies (miniupnp, berkelyDB 4.8, system build tools, etc)






 
