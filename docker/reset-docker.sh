#!/bin/bash

image_name="bkimminich/juice-shop:latest"

container_id=$(docker ps -aqf "ancestor=$image_name")

for i in $( echo $container_id); do
    docker stop $i
    docker rm -f $i
done

docker-compose up -d

#container_id=$(docker ps -aqf "ancestor=$image_name")

#docker logs -f $container_id

