#!/bin/bash 
opc=1
while [ $opc -ne 4 ]
do
	echo 1. Mostrar contenido de la carpeta personal
	echo 2. Mostrar la contraseña cifrada
	echo 3. Se trata del usuario logueado
	echo 4. Salir
	read -p "Introduce opción: " opc
	case $opc in
		1) carpeta=`grep ^$1 /etc/passwd | cut -d":" -f6`
			ls $carpeta ;;
		2) passCifrada=`sudo grep ^$1 /etc/shadow | cut -d":" -f2`
			echo La contraseña cifrada de $1 es $passCifrada;;
		3) usuLog=`whoami`
			if [ $1 = $usuLog ]; then
				echo $1 es el usuario logueado
			else
				echo $1 no es el usuario logueado
			fi
			;;
		4) echo Fin del programa ;;
		*) echo opción incorrecta ;;
	esac
done
