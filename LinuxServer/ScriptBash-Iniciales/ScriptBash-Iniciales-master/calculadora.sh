#!/bin/bash 
read -p "Inserta los numeros a usar"
echo 1. Sumar
echo 2. Restar
echo 3. Multiplicar
echo 4. Dividir
read -n1 -p "Elige una operación: " opc
echo
case $opc in
	1)
		suma=`expr $1 + $2`
		echo Su suma es $suma
		;;
	2)
		resta=`expr $1 - $2`
		echo Su resra es $resta
		;;
	3)
		mul=`expr $1 \* $2`		
		echo Su multipicación es $mul
		;;
	4)
		div=`expr $1 / $2`
		echo Su división es $div
		;;
	*)
		echo Opción incorrecta
		;;
esac
