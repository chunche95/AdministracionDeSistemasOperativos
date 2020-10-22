#!/bin/bash 
read -p "Introduce el número de ficheros que quiere evaluar: " num
for var in `seq 1 $num`
do 
	read -p "Introduce el nombre del fichero: " fich
	while [ ! -f $fich ]
	do
		read -p "$fich no es un fichero. Introduce otro fichero: " fich
	done
	`chmod ugo+x $fich`
	echo $fich ya es un script
done
