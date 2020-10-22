#!/bin/sh

# Poner IP fija en Centos 7

sudo nano -c /etc/sysconfig/network-scripts/ifcfg-enp0s3 <<EOF
BOOTPROTO=static
ONBOOT=yes
IPADDR=10.1.0.51
NETMASK=255.255.0.0
GATEWAY=10.1.0.1
NETWORK=10.1.0.0
DNS1=8.8.8.8
DNS2=8.8.4.4
EOF

sudo systemctl stop NetworkManager
sudo systemctl disable NetworkManager
sudo systemctl restart network.service
