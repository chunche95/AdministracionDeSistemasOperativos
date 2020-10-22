#!/bin/bash 
for var in $*
do
	if [ -f $var ]; then
		echo El contenido del fichero $var es el siguiente: 
		cat $var
		echo
	elif [ -d $var ]; then
		echo El contenido del directorio $var es el siguiente: 
		ls $var
		echo
	else 
		echo $var no es ni un fichero, ni un directorio
	fi
done
