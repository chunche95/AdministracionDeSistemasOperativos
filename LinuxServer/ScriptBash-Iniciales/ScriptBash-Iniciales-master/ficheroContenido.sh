#!/bin/bash 
#pedir nombre fichero
read -p "Introduce el nombre de un fichero: " fichero
if [ -f $fichero ]; then
	if [ -s $fichero ];then
		echo "El fichero $fichero, tiene el siguiente contenido: "
		cat $fichero
	else 
		echo El fichero $fichero está vacío
	fi
else 
	echo El fichero $fichero no existe.
fi

