#!/bin/bash 
opc=0
while [ $opc -ne 5 ]
do
	echo 1. Super95
	echo 2. Super98
	echo 3. Diesel
	echo 4. Diesel Plus
	echo 5. Salir
	read -n1 -p "Elige una opción: " opc
	echo
	case $opc in
		1)
			echo Ha elegido usted Super95
			;;
		2)
			echo Ha elegido usted Super98
			;;
		3)
			echo Ha elegido usted Diesel
			;;
		4)
			echo Ha elegido usted Diesel Plus
			;;
		5)	echo Fin del programa;;
		*)
			echo Opción incorrecta
			;;
	esac
echo
done