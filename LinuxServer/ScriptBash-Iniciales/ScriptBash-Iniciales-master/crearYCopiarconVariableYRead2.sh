#!/bin/bash 
#un script que cree un nuevo archivo y lo mueva a la carpeta personal
#crear nuevo archivo
fichero=""
echo Introduce el nombre del fichero
read fichero
touch $fichero
echo se ha creado $fichero
#mover a la carpeta personal
echo Indica la ruta absoluta a la que quiere mover $fichero
read carpeta
mv $fichero $carpeta
echo se ha movido $fichero a $carpeta

