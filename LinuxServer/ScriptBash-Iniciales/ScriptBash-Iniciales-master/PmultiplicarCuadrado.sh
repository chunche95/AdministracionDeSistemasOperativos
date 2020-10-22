#!/bin/bash 
#un script que si recibe 2 parametros los multiplique, si recibe 1 calcule su cadrado y en el resto de casos indique número de parametros incorrectos
if [ $# -eq 2 ]; then 
	multiplicar=`expr $1 \* $2`
	echo La multiplicacion de $1 y $2 es $multiplicar
elif  [ $# -eq 1 ]; then
	cuadrado=`expr $1 \* $1`
	echo El cuadrado de $1 es $cuadrado
else
	echo Número de parámetros incorrectos
fi
