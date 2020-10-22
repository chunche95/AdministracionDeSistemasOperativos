#!/bin/bash

if [ $# -eq 1 ]; then

	if [ -f $1 ]; then
		echo 'Que deseas hacer con el fichero?'
		echo ''
		echo '1. Mostrar el contenido del fichero'
		echo '2. Copiar el fichero'
		echo '3. Renombrar el fichero'
		echo '4. Convertir el fichero en ejecutable'
		echo '5. Borrar el fichero'
		read -p 'Opción: ' carac

		case $carac in
			1)
				echo 'El contenido del fichero es:'
				cat $1
				;;
			2)
				read -p 'Directorio de destino: ' destino
				if [ -d $destino ]; then
					echo 'Copiando '$1' a '$destino
					cp $1 $destino
				else
					echo 'El directorio de destino no existe'
				fi
				;;
			3)
				read -p 'El nuevo nombre será: ' nombre
				echo 'Renombrando...'
				mv $1 $nombre
				;;
			4)
				echo 'Conviertiendo...'
				chmod 777 $1
				mv $1 $1.sh
				;;
			5)
				read -p 'Seguro que quieres borrarlo? (s para Sí) ' defi
				if [ $defi = s ]; then
					rm -R $1
				else
					echo 'No borro nada entonces'
				fi
				;;
		esac

	else
		echo 'El fichero no existe'

	fi

else
	echo 'Debes introducir un solo parámetro'

fi
