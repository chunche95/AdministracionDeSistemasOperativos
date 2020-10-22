#!/bin/bash 
resp=s
while [ $resp = s -o $resp = S ]
do 
	read -p "Introduce un fichero: " fich
	while [ ! -f $fich ]
	do
		read -p "Fichero incorrecto. Introduce uno nuevo: " fich
	done
	palabras=`cat $fich | wc -w`
	echo El fichero $fich tiene $palabras palabras
		read -p "Desea continuar?(s/n) " resp
done
