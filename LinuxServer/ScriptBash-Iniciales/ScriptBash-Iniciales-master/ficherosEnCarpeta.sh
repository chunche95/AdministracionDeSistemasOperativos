#!/bin/bash 
cont=0
read -p "Introduce una carpeta: " carp
if [ ! -d $carp ]; then
	mkdir $carp
	echo la carpeta $carp no existía, pero ha sido creada
fi

read -p "Deseas introducir un nuevo fichero? (s/n) " resp
cd $carp
while [ $resp = s ]
do
	read -p "Introduce el nombre del nuevo fichero: " fich
	if [ -f $fich ]; then
		echo No se puede crear $fich, ya existe
	else	
		touch $fich
		cont=`expr $cont + 1`
	fi
	read -p "Deseas seguir introduciendo ficheros? (s/n) " resp
done
echo Se han introducido $cont ficheros
