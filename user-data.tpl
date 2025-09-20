#!/bin/bash
set -xe

# Install Docker on Amazon Linux 2
yum update -y
amazon-linux-extras install docker -y || yum install -y docker
service docker start
usermod -a -G docker ec2-user

# Wait a little
until docker info >/dev/null 2>&1; do sleep 2; done

# Login to DockerHub (credential variables passed from Terraform)
echo "${dockerhub_pass}" | docker login -u "${dockerhub_user}" --password-stdin


# Stop any existing containers and remove (idempotent)
for service in frontend user products orders cart; do
  docker rm -f $${service} || true
done

# Pull images
docker pull ${dockerhub_repo_prefix}/frontend-service:latest
docker pull ${dockerhub_repo_prefix}/user-service:latest
docker pull ${dockerhub_repo_prefix}/product-service:latest
docker pull ${dockerhub_repo_prefix}/order-service:latest
docker pull ${dockerhub_repo_prefix}/cart-service:latest



# Run backend containers: bind to host ports 3001-3004
docker run -d --name user -e SERVICE_NAME=user -e PORT=3001 -p 3001:3001 --restart unless-stopped ${dockerhub_repo_prefix}/user-service:latest
sleep 2;
docker run -d --name product -e SERVICE_NAME=product -e PORT=3002 -p 3002:3002 --restart unless-stopped ${dockerhub_repo_prefix}/product-service:latest
sleep 2;
docker run -d --name order -e SERVICE_NAME=order -e PORT=3003 -p 3003:3003 --restart unless-stopped ${dockerhub_repo_prefix}/order-service:latest
sleep 2;
docker run -d --name cart -e SERVICE_NAME=cart -e PORT=3004 -p 3004:3004 --restart unless-stopped ${dockerhub_repo_prefix}/cart-service:latest
sleep 2;

# Run frontend: container listens on 3000, map host port 80 -> container 3000
docker run -d --name frontend -e SERVICE_NAME=frontend -e PORT=3000 -p 80:3000 --restart unless-stopped ${dockerhub_repo_prefix}/frontend-service:latest

# Basic health check: wait and show ps
sleep 10
docker ps -a
