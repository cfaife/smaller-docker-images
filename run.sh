#!/bin/bash


# buiding the application

CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

#buidling the images

# scratch
docker image build -t my-image-scratch -f Dockerfile.scratch .


# alpine
docker image build -t my-image-alpine -f Dockerfile.alpine .