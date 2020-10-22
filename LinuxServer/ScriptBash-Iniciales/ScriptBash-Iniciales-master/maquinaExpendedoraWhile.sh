#!/bin/bash 
opc=0
while [ $opc -ne 5 ]
do
	clear	
	echo 1. Oreo 	    2€
	echo 2. Regalices   1€
	echo 3. Agua 	    1€
	echo 4. Sandwich    3€
	echo 5. Salir
	read -n1 -p "Elige una opción: " opc
	echo
	case $opc in
		1)	
			echo Has elegido Oreo
			precio=2
			;;
		2)
			echo Has elegido Regalices
			precio=1;;
		3)
			echo Has elegido Agua
			precio=1;;
		4)
			echo Has elegido Sandwich
			precio=3;;

		5) 	echo Fin del programa
			;;
		*)
			echo Producto incorrecto
			;;
	esac
	read -p "Indica el importe introducido: " imp

	if [ $imp -gt $precio ]; then
		cambio=`expr $imp - $precio`
		echo Su cambio es $cambio €
	elif [ $imp -lt $precio ]; then
		falta=`expr $precio - $imp`
		echo Te falta $falta € para comprar el producto
	else
		echo Importe exacto
	fi;
	read -n1 -p "Introduce cualquier tecla para continuar..." tecla
done
