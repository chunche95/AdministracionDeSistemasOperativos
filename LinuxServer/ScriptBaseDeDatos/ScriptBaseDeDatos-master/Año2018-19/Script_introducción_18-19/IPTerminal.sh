#!/bin/sh

echo "Cambiando IP"
sudo ifconfig enp0s3 10.1.0.54 netmask 255.255.0.0

echo "Reiniciando adaptador"
sudo systemctl restart network.service

sleep 2
echo "Trabajo terminado"
clear
