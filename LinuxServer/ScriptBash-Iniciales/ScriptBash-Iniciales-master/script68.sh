#!/bin/bash 
if [ $# -ne 0 ]; then
	dire=$1
	while [ ! -d $dire ]
	do
	read -p "El parametro introducido no es un directorio. Introduce uno: " dire
	done
	cont=0
	cd $dire
	for var in `ls`
	do
		
		if [ -f $var ] && [ ! -x $var ]; then
		cont=`expr $cont + 1`
		fi
	done	
	echo $dire contiene $cont ficheros de texto
else 
	echo Nº parametros incorrecto
fi

