#!/bin/bash
set -x
exec > /tmp/startup.log 2>&1
sudo yum install -y docker
sudo usermod -a -G docker ec2-user
sudo service docker start

sudo mkdir /root/.docker

sudo echo "{\"credsStore\": \"ecr-login\"}" > /home/hadoop/config.json

sudo mv /home/hadoop/config.json /root/.docker/config.json

sudo docker run --rm -v /home/hadoop:/data -v /usr/bin:/go/src/github.com/awslabs/amazon-ecr-credential-helper/bin/local kasko/ecr-credential-helper

sudo docker rmi kasko/ecr-credential-helper
