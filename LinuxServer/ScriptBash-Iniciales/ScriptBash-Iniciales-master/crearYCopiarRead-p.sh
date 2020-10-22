#!/bin/bash 
#un script que cree un nuevo archivo y lo mueva a la carpeta personal
#crear nuevo archivo
read -p "Introduce el nombre del fichero:" fichero
touch $fichero
echo se ha creado $fichero
#mover a la carpeta personal
read -p "Introduce la ruta:" ruta
mv $fichero $ruta
echo se ha movido $fichero a $ruta

