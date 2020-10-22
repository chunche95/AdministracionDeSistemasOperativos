#!/bin/bash
clear
sudo /etc/init.d/network force-reload
sudo /etc/init.d/network stop
sudo /etc/init.d/network start
# Busco el ping si esta OK
ping -c 4 8.8.8.8 | grep ttl
if [ $? -eq 1 ]; then
echo "Levantamos enp0s8"
sudo ifdown enp0s3
sudo ifconfig enp0s8 up
echo "Ejecute sudo ifup enp0s8"
else
#sudo ifdown enp0s8
echo "Levantamos enp0s3"
sudo ifconfig enp0s3 up
sudo ifconfig enp0s8 down
echo "Ejecute sudo ifdown enp0s8"
fi

