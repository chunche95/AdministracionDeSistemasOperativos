#!/bin/bash

vari=0
while [ $vari -eq 0 ]
do
	read -p 'Introduce el destino: ' fich

	if [ -f $fich ]; then
		cat $fich
		vari=1
	elif [ -d $fich ]; then
		ls -l $fich
		vari=1
	else
		echo 'No es ni fichero ni directorio'
	fi
done
