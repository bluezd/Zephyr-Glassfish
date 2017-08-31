#!/bin/bash


# build glassfish
# docker build --build-arg http_proxy=http://cn-proxy.jp.oracle.com:80 -t glassfish-4.1.2-jdk-8-postgres .

PASSD="oracle"

echo -e "# starting postgres db #"
#sudo docker run --name postgres -e POSTGRES_PASSWORD=oracle -p 5432:5432 -d postgres:latest
sudo docker run --name postgres -e POSTGRES_PASSWORD=oracle -d postgres:latest

sleep 30

echo -e "\n# starting glassfish #"
#sudo docker run -p 8080:8080 -p 4848:4848 -p 8181:8181 --link mysql:mysqlDB glassfish-5.0-db
#sudo docker run --cap-add=NET_ADMIN -p 8080:8080 -p 4848:4848 -p 8181:8181 -ti -v /home/jude/Docker/glassfish-5.0-db/lib/:/mnt --link postgres:postgres -ti bluezd/zephyr-glassfish /bin/bash

sudo docker run  -p 8080:8080 -p 4848:4848 -p 8181:8181 -ti --link postgres:postgresDBAddr bluezd/zephyr-glassfish 
