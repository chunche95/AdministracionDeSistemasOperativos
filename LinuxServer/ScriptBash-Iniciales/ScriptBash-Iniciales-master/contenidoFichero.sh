#!/bin/bash
if [ $# -eq 1 ]; then
	fich=$1
	while [ ! -f $fich ]
	do
		read -p "El parametro no es un fichero, introduce otro: " fich
	done
	if [ -s $fich ]; then
	#si tiene tamaño 
		echo "Este fichero ya tiene contenido pero le añado más" >> $fich
	else
	#si está vacío
		echo "Ya no es un fichero vacío" >> $fich
	fi
else 
	echo Nº parametros incorrecto
fi

