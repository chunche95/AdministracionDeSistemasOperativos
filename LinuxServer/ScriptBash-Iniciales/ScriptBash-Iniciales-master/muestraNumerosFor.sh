#!/bin/bash 
#Realiza un script que pida dos números y muestre todos los que hay entre ellos dos
read -p "Introduce un número: " num1
read -p "Introduce otro número: " num2
for variable in `seq $num1 2 $num2`
do 
	echo $variable
done
