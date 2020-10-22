#!/bin/bash

# Install playonlinux in Ubuntu
wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
sudo wget http://deb.playonlinux.com/playonlinux_cosmic.list -O /etc/apt/sources.list.d/playonlinux.list
sudo apt-get update
sudo apt-get install playonlinux -y

# Install winbind
sudo apt-get install winbind -y


echo "Corrigiendo error in main al instalar Office"
# https://mega.nz/#!bggFzD6R!ynSJXfUjGQRRr7cWwlzMWoQBJzONT5tD54Ed5FJ38u0
