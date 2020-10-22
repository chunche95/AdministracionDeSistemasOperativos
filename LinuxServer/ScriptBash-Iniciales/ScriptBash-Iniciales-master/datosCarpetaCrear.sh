#!/bin/bash 
#un script que cree un nuevo archivo y lo mueva a la carpeta personal
#crear nuevo archivo
read -p "Introduce el nombre de la carpeta:" carpeta
read -p "Introduce la ruta donde quiere crearla:" ruta
if [ -d $ruta ]; then
#crear carpeta
cd $ruta
mkdir $carpeta
echo "Carpeta $carpeta creada en $ruta"
else 
echo "Ruta incorrecta"
fi

