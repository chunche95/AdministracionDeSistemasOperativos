#!/bin/bash 
#pedir nombre de un fichero de texto y decir si las dos primeras palabras de su contenido son iguales
read -p "Introduce un fichero: " fich

if [ -f $fich ] && [ -s $fich]; then 
	primera=`head -n1 $fich | cut -d" " -f1`
	segunda=`head -n1 $fich | cut -d" " -f2`
	if [ $primera = $segunda ]; then
		echo "Las dos primeras palabras de $fich son iguales"
	else
		echo "Las dos primeras palabras de $fich son diferentes"
	fi
else
	echo $fich no es un fichero o esta vacio
fi


