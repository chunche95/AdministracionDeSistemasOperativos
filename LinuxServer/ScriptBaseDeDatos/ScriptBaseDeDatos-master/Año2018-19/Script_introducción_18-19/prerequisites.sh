#!/bin/sh

# Instalar las dependencias faltantes de Oracle Database 18c.

sudo yum -y install oracle-database-preinstall-18c-1.0-1.el7.x86_64.rpm
echo "Instalando"
sleep 2
sudo rm  oracle-database-preinstall-18c-1.0-1.el7.x86_64.rpm
echo "Liberando espacio..."
sleep 2
echo "Hecho!"