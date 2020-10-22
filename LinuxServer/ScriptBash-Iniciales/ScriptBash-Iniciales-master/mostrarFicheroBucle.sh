#!/bin/bash 
resp=s
while [ $resp = s ] || [ $resp = S ]
do
	read -p "Introduce un fichero: " fich
	if [ -f $fich ] && [ -s $fich ]; then
		echo este es el contenido de $fich
		cat $fich
	else
		echo No se puede mostrar $fich
	fi
	read -p "Deseas continuar? (s/n)" resp
done
