#!/bin/bash
#by @izobretatel9

#добавление пользователя Devops
adduser devops
usermod -aG sudo devops # добавляем пользователя в sudo
mkdir -p /home/devops/.ssh #создаем
echo "" | sudo tee -a /home/devops/.ssh/authorized_keys

#добавление пользователя flant
adduser flant
usermod -aG sudo flant # добавляем пользователя в sudo
mkdir -p /home/flant/.ssh #создаем
echo "" | sudo tee -a /home/flant/.ssh/authorized_keys

#добавление пользователя research
adduser research
usermod -aG sudo research # добавляем пользователя в sudo
mkdir -p /home/research/.ssh #создаем
echo "" | sudo tee -a /home/research/.ssh/authorized_keys

sed -i 's/%sudo\s*ALL=(ALL:ALL)\s*ALL\s*/%sudo   ALL=(ALL:ALL) NOPASSWD: ALL/g' /etc/sudoers
nano /etc/hostname
nano /etc/hosts

adduser usr
usermod -aG sudo usr
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service ssh restart

#fdisk -l
#mkfs.ext4 /dev/vda
#e2label /dev/vda nvme # Lable
#echo "LABEL=nvme /mnt/nvme ext4 defaults 0 0" | sudo tee -a /etc/fstab