#!/bin/bash 
for var in $*
do
	if [ ! -f $var ] && [ ! -d $var ]; then
		read -p "Quieres crear $var como fichero o como directorio?(f/d) " resp
		if [ $resp = f ]; then
			touch $var
		elif [ $resp = d ]; then
			mkdir $var
		else
			echo respuesta incorrecta
		fi
	else
		echo $var no se puede crear porque ya existe
	fi
done

