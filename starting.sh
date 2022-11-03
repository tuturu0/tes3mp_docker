#!/bin/bash
sudo mkdir -p /opt/tes3mp/
cd /opt/tes3mp/
wget "https://github.com/TES3MP/TES3MP/releases/download/tes3mp-0.8.1/tes3mp-server-GNU+Linux-x86_64-release-0.8.1-68954091c5-6da3fdea59.tar.gz"
tar -xvf "tes3mp-server-GNU+Linux-x86_64-release-0.8.1-68954091c5-6da3fdea59.tar.gz"  
cd TES3MP-server/ 
wget "https://raw.githubusercontent.com/tuturu0/tes3mp_docker/main/Dockerfile" 
chmod +777 Dockerfile 
sudo ufw allow 25565


if [[ -d /opt/tes3mp/TES3MP-server/ ]] && [[ -e /opt/tes3mp/TES3MP-server/tes3mp-server-default.cfg ]]
then
        filename="/opt/tes3mp/TES3MP-server/tes3mp-server-default.cfg"
        echo "Please enter your server's password"
        read ReplacePass
        sed -i "s/^password .*$/password = $ReplacePass/" $filename
        echo "Please enter your server's name"
        read ReplaceHostname
        sed -i "s/^hostname .*$/hostname = $ReplaceHostname/" $filename
else
        echo "No config file...Aborting..."
fi

docker build -t tes3mp:1 .
image=$(docker images | grep tes3mp | awk '{print $3}')
docker run -d -p 25565:25565/udp $image
