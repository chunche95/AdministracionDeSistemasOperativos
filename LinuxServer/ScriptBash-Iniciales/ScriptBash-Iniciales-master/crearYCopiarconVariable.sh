#!/bin/bash 
#un script que cree un nuevo archivo y lo mueva a la carpeta personal
#crear nuevo archivo
fichero="archivo2"
touch $fichero
echo se ha creado $fichero
#mover a la carpeta personal
mv $fichero /home/mgf
echo se ha movido $fichero a la carpeta personal /home/mgf

