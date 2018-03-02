#!/bin/bash

# UPDATE
apt-get update
apt-get upgrade -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo apt-get install -y docker-ce
sudo apt-get install -y docker-compose

# FORMAT DISK SDC
fdisk /dev/sdc <<EOF
n
p
1


w
EOF

sudo mkfs -t ext4 /dev/sdc <<EOF
yes
EOF



#MOUNT DISK
sudo -i blkid
mkdir /RabbitMQData

mount /dev/sdc /RabbitMQData

disk1=$(sudo -i blkid | grep -e sdc | awk '{print $2}' | tr -d '"')
echo "$disk1 /RabbitMQData   ext4   defaults,nofail   1   2"  >> /etc/fstab


mkdir ~/Docker-Compose
mkdir ~/Docker-Compose/RabbitMQ

cp /tmp/Lykke.RabbitMQ.Template/docker-compose.yml ~/Docker-Compose/RabbitMQ/docker-compose.yml
cp /tmp/Lykke.RabbitMQ.Template/definitions.json ~/Docker-Compose/RabbitMQ/definitions.json
cp /tmp/Lykke.RabbitMQ.Template/rabbitmq-env.conf ~/Docker-Compose/RabbitMQ/rabbitmq-env.conf
cp /tmp/Lykke.RabbitMQ.Template/rabbitmq.config ~/Docker-Compose/RabbitMQ/rabbitmq.config

