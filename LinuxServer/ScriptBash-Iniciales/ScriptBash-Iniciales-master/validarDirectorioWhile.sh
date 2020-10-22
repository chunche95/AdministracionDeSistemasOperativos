#!/bin/bash 
read -p "Introduce un directorio: " carp
#validar
while [ ! -d $carp ]
do
	echo no es un directorio
	read -p "Por favor, introduce un directorio: " carp
done
#fin de la validación
echo Este es el contenido de $carp:
ls $carp
