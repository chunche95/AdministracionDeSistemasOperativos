#!/bin/bash 
if [ $# -ne 1 ]; then
	read -p "Introduce fichero: " fichero
else
	fichero=$1
fi
	while [ ! -f $fichero ]
	do
		read -p "Esto no es un fichero, introduce otro: " fichero
	done

	if [ -x $fichero ]; then
		echo $fichero es un script
	else
		echo $fichero no es un script
	fi

