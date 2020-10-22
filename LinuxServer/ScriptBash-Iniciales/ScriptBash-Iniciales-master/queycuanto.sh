#!/bin/bash
if [ -d $1  ]; then
	echo $1 es un directorio y su tamaño es el siguiente: 
	stat -c "%s K %n" $1
elif [ -f $1 ]; then
	echo $1 es un archivo regular y su tamaño es el siguiente: 
	stat -c "%s K %n" $1
else 
	echo  $1 no existe
fi
