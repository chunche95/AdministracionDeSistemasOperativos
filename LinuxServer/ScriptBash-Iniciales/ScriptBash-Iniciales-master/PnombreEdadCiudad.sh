#!/bin/bash 
#un script que pida tu nombre, edad y ciudad donde vives
if [ $# -eq 3 ]; then 
	echo Hola $1, tienes $2 años y vives en $3.
else
	echo Número de parámetros incorrectos
fi
