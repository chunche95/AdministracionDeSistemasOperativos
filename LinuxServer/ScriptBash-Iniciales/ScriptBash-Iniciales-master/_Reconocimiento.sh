#!/bin/bash
echo "BIENVENIDO AL PROGRAMA DE RECONOCIMIENTO DE CARACTERES DE ENTRADA POR TECLADO."
echo "------------------------------------------------------------------------"
read -n 1 -p "Introduzca un dato de entrada por teclado: " entrada 
echo ""
case $entrada in

	[a-z,A-Z]) 
		echo "ha introducido una letra";
	;;
	[0-9])
		 echo "Ha introducido un numero";
	;;
	*)
		 echo "Ha introducido un caracter especial";
	;;
esac
exit;
clear
