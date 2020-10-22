#!/bin/bash 
# Realiza un script que pida dos números y muestre todos los que hay entre ellos dos en orden ascendente e indique si el primero es mayor que el segundo
read -p "Introduce un número: " num1
read -p "Introduce otro número: " num2

if [ $num1 -gt $num2 ]; then
	suma=`expr $num1 + $num2`
	echo La suma de $num1 y $num2 es $suma
elif [ $num1 -lt $num2 ]; then
	resta=`expr $num2 - $num1`
	echo La resta de $num1 y $num2 es $resta
else 
	echo $num1 es igual a $num2
fi
