#!/bin/bash 
#un script reciba directorio si existe muestre su contenido y sino lo debe crear y decir que lo ha creado
if [ $# -eq 1 ]; then
	if [ -d $1 ]; then 
		echo Este es el contenido de $1:
		ls $1
	else
		if [ -f $1 ]; then
			echo $1 es un fichero que ya existe
		else	
			mkdir $1
			echo La carpeta $1 ha sido creada
		fi
	fi
else
	echo Nº de parámetros incorrectos
fi
