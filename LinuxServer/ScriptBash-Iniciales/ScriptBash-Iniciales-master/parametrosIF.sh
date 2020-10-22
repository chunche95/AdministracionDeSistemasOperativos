#!/bin/bash 


for var in $*
do
	if [ -f $var ]; then
		rm $var
		echo fichero $var borrado
	elif [ -d $var ]; then
		echo El contenido de la carpeta $var es:
		ls $var	
	else
		echo $var no está en el sistema	
	fi
done
