#!/bin/bash
FILE=has_run

if [ -f $FILE ];
then
   echo "File $FILE exists. this server is already setup"
   sed -i 'setup_images' /etc/rc.local
   #halt
else
   echo "File $FILE does not exist. and I will du setup" 

   echo "Starting seting up yum and install packages"
   yum update -y
   
   echo "Setup ACPI Service"
   yum install acpid -y
   systemctl enable acpid

   echo "Setup Cloud-init"
   adduser centos
   echo "centos ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
   yum install epel-release.noarch -y
   yum install cloud-init -y
   echo user: centos >> /etc/cloud/cloud.cfg 

   echo "Setp Cloud-utils-grow"
   yum install cloud-utils-growpart -y

   echo "Disable zerofonf"
   echo "NOZEROCONF=yes" >> /etc/sysconfig/network

   echo "Fixing grub"
   sed -i 's/rhgb quiet/console=tty0 console=ttyS0,115200n8/g' /etc/default/grub
   grub2-mkconfig -o /boot/grub2/grub.cfg

   echo "Clean up"
   sed -i '/UUID=/d' /etc/sysconfig/network-scripts/ifcfg-ens3


   echo "Done"
   touch $FILE

   echo "Reboot file"
   reboot

fi



