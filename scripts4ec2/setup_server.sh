#! /bin/bash

yum update -y
amazon-linux-extras install docker
service docker start
usermod -a -G docker ec2-user
docker info
docker pull nginx
docker run -d -p 80:80 --name web-nginx nginx

# Install python modules
easy_install pip
pip install BeautifulSoup4
pip install pandas
touch /tmp/signal
date