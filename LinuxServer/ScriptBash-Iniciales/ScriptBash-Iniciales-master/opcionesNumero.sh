#!/bin/bash
if [ $# -eq 1 ]; then 
	opc=a
	while [ $opc != d ]
	do
		echo
		echo a. Mostrar su número triple
		echo b. Mostrar su mitad
		echo c. Mostrar su tabla de multiplicar
		echo d. Salir
		read -n1 -p "Elige una opción: " opc
		echo
		case $opc in
			a)
				triple=`expr $1 \* 3`
				echo El triple de $1 es $triple
				;;
			b)
				esPar=`expr $1 % 2`
				if [ $esPar -eq 0 ]; then
					mitad=`expr $1 / 2`
					echo La mitad de $1 es $mitad
				else 
					echo no se puede porque $1 es impar
				fi
				;;
			c)
				digito=$1
				for var in {0..10}
				do 
				tabla=`expr $digito \* $var`
				echo $digito x $var=$tabla
				done

				;;
			d)
				echo Saliendo......
				;;
			*)
				echo Opción incorrecta
				;;
		esac
	done
else
	echo Nº parametros incorrecto
fi
