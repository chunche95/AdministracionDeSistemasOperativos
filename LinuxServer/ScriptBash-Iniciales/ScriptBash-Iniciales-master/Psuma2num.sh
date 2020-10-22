#!/bin/bash 
#Introduce los numeros a sumar
if [ $# -eq 2 ]; then
	echo La suma es $(($1 + $2))
	echo La suma es `expr $1 + $2`
else
	echo El número de parametros es incorrecto
fi

#Introducimos como parametro la operción a realizar
if [ $# -eq 3 ]; then
	echo La suma es $(($*))
	echo La suma es `expr $*`
else
	echo El número de parametros es incorrecto
fi
