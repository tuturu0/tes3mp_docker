FROM ubuntu:22.04

RUN apt-get update && apt-get -y install libluajit-5.1-dev wget && mkdir -p /opt/tes3mp/ && \
ufw allow 25565 

WORKDIR /opt/tes3mp/TES3MP-server

COPY . /opt/tes3mp/TES3MP-server

EXPOSE 25565

CMD  ["./tes3mp-server"]
