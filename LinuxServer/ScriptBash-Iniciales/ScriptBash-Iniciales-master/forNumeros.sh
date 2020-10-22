#!/bin/bash 
# Realiza un script que pida dos números y muestre todos los que hay entre ellos dos en orden ascendente e indique si el primero es mayor que el segundo
read -p "Introduce un número: " num1
read -p "Introduce otro número: " num2

if [ $num1 -gt $num2 ]; then
	for var in `seq $num2 1 $num1`
	do
	echo $var
	done
	echo $num1 es mayor que $num2
else
	for var in `seq $num1 1 $num2`
	do
	echo $var
	done
	echo $num2 es mayor que $num1
fi
