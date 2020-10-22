#!/bin/bash 
#un script que reciba un usuario como parametro y nos muestre la fecha de la última modificación de su contraseña, si el usuario no está en el sistema se debe notificar.
if [ $# -eq 1 ]; then 
	lineas=`sudo cut -d":" -f1 /etc/shadow | grep ^$1$  | wc -l`
	if [ $lineas -gt 0 ]; then
		fecha=`sudo grep ^$1 /etc/shadow | cut -d":" -f3`
		echo $fecha
	else
		echo No existe el usuario $1
	fi
else
	echo Número de parámetros incorrectos
fi
