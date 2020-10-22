#!/bin/bash

var=0
while [ $var -eq 0 ]
do

	read -p 'Introduzca el fichero ' fich
	if [ -f $fich ]; then
		if [ -x $fich ]; then
			echo 'Tiene permisos de ejecución'
		else
			echo 'No tiene permisos de ejecución'
		fi

		var=1
	else
		echo 'No es un fichero'
	fi

done
