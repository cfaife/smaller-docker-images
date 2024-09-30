#!/bin/bash

echo 'Stopping and removing current container'
declare -a container_array=$(docker container ps -aq)
for container_id in ${container_array[a]}
do  
    docker container stop $container_id
    docker container rm   $container_id
done

echo 'Verify images and deleting them'
declare -a image_array=$(docker image ls -q)
for image_id in  ${image_array[@]}
do 
    docker image rm -f $image_id
done


echo 'Removing the binary artficact if it exists'
if [ -e main ]; then
    rm main
fi

echo 'Building the binary'
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

echo 'Buidling the image `scratch`'
docker image build -t my-image-scratch -f Dockerfile.scratch .


echo 'Buidling the image `alpine`'
docker image build -t my-image-alpine -f Dockerfile.alpine .

echo 'Running it'
docker container run -d  -p 8082:8080 --name scratch my-image-scratch 
docker container run -d  -p 8081:8080 --name alpine my-image-alpine 