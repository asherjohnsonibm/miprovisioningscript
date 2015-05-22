#!/bin/bash
# Update System 
sudo apt-get -y update
# Install Build Tools
sudo apt-get -y -f install vim make git lxc curl

# Prevent root login via SSH
sed -i -e "s/PermitRootLogin [y|Y]es/PermitRootLogin no/g" /etc/ssh/sshd_config 
service ssh restart 

# Install Latest Ubuntu Trusty Docker Package
sudo apt-get -y install linux-image-extra-$(uname -r)
sudo sh -c "wget -qO- https://get.docker.io/gpg | apt-key add -"
sudo sh -c "echo deb http://get.docker.io/ubuntu docker main\ > /etc/apt/sources.list.d/docker.list"
sudo apt-get update
sudo apt-get -y install lxc-docker
echo 'DOCKER_OPTS="-e lxc"' >> /etc/default/docker
sudo service docker restart

# Install the consul container
git clone https://github.com/vinomaster/docker-consul-sd /usr/share/docker-consul-sd
cd /usr/share/docker-consul-sd
make build
make start-single

