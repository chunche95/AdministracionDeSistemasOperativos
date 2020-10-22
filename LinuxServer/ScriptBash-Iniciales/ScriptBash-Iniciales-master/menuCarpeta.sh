#!/bin/bash
if [ $# -eq 1 ]; then 
	opc=a
	while [ $opc != d ]
	do	
		echo a. Mostrar contenidos
		echo b. Cuántos elementos contiene la carpeta
		echo c. Ampliar permisos a la carpeta
		echo d. Salir
		read -n1 -p "Elige una opción: " opc
		echo
		case $opc in
			a)	
				echo El contenido de la carpeta $1 es:
				ls $1
				;;
			b)
				lineas=`ls $1 | wc -l`
				echo $1 contiene $lineas elementos
				;;
			c)
				chmod 777 $1
				echo Permisos ampliados
				;;
			d)
				echo Fin del programa
				;;

			*)
				echo Opción incorrecta
				;;
		esac
	done
else
	echo parámetro incorrecto
fi
