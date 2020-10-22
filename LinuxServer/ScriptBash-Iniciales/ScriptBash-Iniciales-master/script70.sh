#!/bin/bash 
opc=1
while [ $opc != d ]
do
	echo
	echo a. Mostrar contenido
	echo b. Copiar el contenido de esta carpeta a otra
	echo c. Borrar carpeta
	echo d. Salir
	read -p "Introduce opción: " opc
	case $opc in
		a) ls $1 ;; 
		b) read -p "Introduce el nombre de la carpeta destino: " carp
			cp $1/* $carp ;;
		c) rm -r $1 ;;
		d) echo Fin del programa ;;
		*) echo opción incorrecta ;;
	esac
done

