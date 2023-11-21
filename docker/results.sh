#!/bin/bash

image_name="bkimminich/juice-shop:latest"

container_id=$(docker ps -aqf "ancestor=$image_name")

for i in $( echo $container_id); do
    echo "===================================="
    docker inspect --format='{{.Name}}' $i
    echo -n "Challanges solved (out of 25): "
    docker logs $i 2>&1 | grep -iv "ERROR" | grep -cE "Solved|Restored"
    echo
    echo
done

