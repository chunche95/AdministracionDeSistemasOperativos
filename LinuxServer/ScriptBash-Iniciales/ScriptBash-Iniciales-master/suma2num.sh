#!/bin/bash 
#Introduce los numeros a sumar
read -p "Introduce un número:" num1
read -p "Introduce un número:" num2
#suma los numeros
echo "La suma de $num1 y $num2 es `expr $num1 + $num2`"
echo La suma es $(($num1 + $num2))
echo "La resta de $num1 y $num2 es `expr $num1 - $num2`"
echo La resta es $(($num1 - $num2))
echo "La multiplicación de $num1 y $num2 es `expr $num1 \* $num2`"
echo La multiplicación es $(($num1 * $num2))
echo "La división de $num1 y $num2 es `expr $num1 / $num2`"
echo La división es $(($num1 / $num2))

