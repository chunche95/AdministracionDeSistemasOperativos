#!/bin/bash 

read -p "Introduce un fichero: " fich

#validacion
while [ ! -f $fich ]
do
	read -p "$fich no es un fichero, introduce un fichero: " fich
done

#fin de la validacion
if [ -r $fich ]; then

	echo $fich tiene permisos de lectura
else
	echo $fich no tiene permisos de lectura
fi

if [ -w $fich ]; then

	echo $fich tiene permisos de escritura
else
	echo $fich no tiene permisos de escritura
fi
if [ -x $fich ]; then

	echo $fich tiene permisos de ejecución
else
	echo $fich no tiene permisos de ejecución
fi

