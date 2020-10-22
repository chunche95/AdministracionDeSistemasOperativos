#!/bin/bash 
mes=1
while [ $mes -ne 0 ]
do
	clear
	read -p "Introduce un número de mes: " mes
	case $mes in
		1) echo enero 
		;;
		2) echo febrero 
		;;
		3) echo marzo 
		;;
		4) echo abril 
		;;
		5) echo mayo 
		;;
		6) echo junio 
		;;
		7) echo julio 
		;;
		8) echo agosto 
		;;
		9) echo septiembre 
		;;
		10) echo octubre 
		;;
		11) echo noviembre
		;;
		12) echo diciembre 
		;;
		0) echo fin del programa 
		;;
		*) echo  Este mes no existe
		;;
	esac
	read -n1 -p "Pulsa cualquier tecla para continuar..." tecla
done
