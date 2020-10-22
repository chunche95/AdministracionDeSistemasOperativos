#!/bin/bash 
#Realiza un script que reciba una carpeta como parámetro (hay que validarlo) y muestre el contenido de todos sus ficheros
carp=$1
while [ ! -d $carp ]
do
	read -p "Esto no es una carpeta, introduce carpeta: " carp
done
cd $carp
for var in `ls $carp`
do
	if [ -f $var ]; then
		echo $var es un fichero
		cat $var
	fi
done
