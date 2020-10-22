#!/bin/bash

resp=s
while [ $resp = s ]
do
	clear
	read -p 'Introduzca el fichero ' fich
	echo ''
	if [ -f $fich ]; then
		cat $fich
		echo ''
	else
		echo 'Debes introducir un fichero válido'
		echo ''
	fi
	read -n1 -p 'Quieres sontinuar? (s para si) ' resp
	echo ''
done
