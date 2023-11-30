#!/bin/bash

restart_config_file="/etc/needrestart/needrestart.conf"
sed -i "s/^#\\\$nrconf{restart} = 'i';/\$nrconf{restart} = 'a';/" "$restart_config_file"

sudo apt update -y
sudo apt -y install lrzsz
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible -y
sudo apt install ansible -y
sudo apt-get install python3 -y
sudo apt-get install python3-pip -y
sudo apt-get install python-boto3 -y
sudo pip3 install boto3
sudo apt install awscli -y
sudo pip show boto3
sudo pip show botocore
sudo python3 --version
sudo ansible --version
sudo aws --version

cp /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.bk

echo [defaults] > /etc/ansible/ansible.cfg
echo [inventory] >> /etc/ansible/ansible.cfg
echo [ssh_connection] >> /etc/ansible/ansible.cfg
sed -i '/\[ssh_connection\]/a\ssh_args = -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null' /etc/ansible/ansible.cfg
sed -i '/\[inventory\]/a\enable_plugins = aws_ec2' /etc/ansible/ansible.cfg
sed -i '/\[defaults\]/a\inventory = /home/ubuntu/aws_ec2.yaml' /etc/ansible/ansible.cfg
sed -i '/aws_ec2.yaml/a\remote_user = ubuntu' /etc/ansible/ansible.cfg
sed -i '/remote_user = ubuntu/a\private_key_file = /home/ubuntu/terraform-new-key1.pem' /etc/ansible/ansible.cfg
