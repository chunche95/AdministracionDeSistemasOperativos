#!/bin/bash

cont=0

while [ $cont -eq 0 ]
do

read -p 'Introduce el fichero ' fich

if [ -f $fich ]; then
	echo 'Que deseas hacer con el fichero?'
	echo ''
	echo '1. Mostrar el contenido del fichero'
	echo '2. Copiar el fichero'
	echo '3. Renombrar el fichero'
	echo '4. Convertir el fichero en ejecutable'
	echo '5. Borrar el fichero'
	echo '6. Salir'
	read -p 'Opción: ' carac
		case $carac in
		1)
			echo 'El contenido del fichero es:'
			cat $fich
			;;
		2)
			read -p 'Directorio de destino: ' destino
			if [ -d $destino ]; then
				echo 'Copiando '$fich' a '$destino
				cp $fich $destino
			else
				echo 'El directorio de destino no existe'
			fi
			;;
		3)
			read -p 'El nuevo nombre será: ' nombre
			echo 'Renombrando...'
			mv $fich $nombre
			;;
		4)
			echo 'Conviertiendo...'
			chmod 777 $fich
			mv $fich $fich.sh
			;;
		5)
			read -p 'Seguro que quieres borrarlo? (s para Sí) ' defi
			if [ $defi = s ]; then
				rm -R $fich
			else
				echo 'No borro nada entonces'
			fi
			;;
		6)
			cont=1
			;;
	esac
else
	echo 'El fichero no existe'
fi

done
