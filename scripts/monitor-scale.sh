#!/bin/bash

#Retrieve the latest git commit hash
TAG=`git rev-parse --short HEAD` 

#Build the docker image
docker build -t 127.0.0.1:30400/monitor-scale:$TAG -f applications/monitor-scale/Dockerfile applications/monitor-scale

#Setup the proxy for the registry
docker stop socat-registry; 
docker rm socat-registry; 
docker run -d --name socat-registry -p 30400:5000 chadmoon/socat:latest bash -c "socat TCP4-LISTEN:5000,fork,reuseaddr TCP4:host.docker.internal:57367"

echo "5 second sleep to make sure the registry is ready"
sleep 5;

#Push the images
docker push 127.0.0.1:30400/monitor-scale:$TAG

#Stop the registry proxy
docker stop socat-registry

# Create the deployment and service for the monitor-scale node server
sed 's#127.0.0.1:30400/monitor-scale:latest#127.0.0.1:30400/monitor-scale:'$TAG'#' applications/monitor-scale/k8s/deployment.yaml | kubectl apply -f -
