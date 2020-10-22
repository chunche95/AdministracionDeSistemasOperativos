#!/bin/sh

echo "Intalación de Docker en Ubuntu 18.04"
echo ""
echo "- Actualizando paquetes del sistema"
sudo pat-get -y update
echo ""
echo "********************************************"
echo ""
echo "- Instalando paquetes necesarios... (Prerequisitos)"
echo ""
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
echo ""
echo "********************************************"
echo "- Agregando las clave GPG para el repositorio oficial de Docker al sistema"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "********************************************"
echo ""
echo "- Agregando el repositorio de Docker."
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
echo "********************************************"
echo ""
echo "- Actualizando el sistema"
sudo apt update
echo "- Comprobando instalación del repositorio de Docker."
apt-cache policy docker-ce
sleep 5
echo "--------------------- INSTALACIÓN DE DOCKER ---------------------"
sudo apt install docker-ce
sleep 5
echo ">>>>>  ESTADO DEL PROGRAMA "
sudo systemctl status docker
sleep 5 
clear
echo "- Añadiendo usuario del sistema al grupo DOCKER"
sudo chmod 666 /var/run/docker.sock
ls -l /lib/systemd/system/docker.socket
sudo usermod -aG docker ${USER}
sudo usermod -aG docker $USER
su - ${USER}
echo ""
echo ""
echo "- Usuario(s) del grupo DOCKER"
echo "" 
id -nG
echo ""
echo "En caso de necesitar añadir más usuario use:  \p
    sudo usermod -aG docker NOMBREUSUARIO "
sleep 5
clear
docker info

