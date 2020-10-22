#!/bin/bash 
#Realiza un script que reciba una serie de parametros y nos diga cuantos de ellos son carpetas
for var in $* 
do 
	if [ -d $var ]; then
		echo $var es una carpeta
		cont=`expr $cont + 1`
	else
		echo $var no es una carpeta
	fi
done
echo "Hemos recibido $cont carpetas"
