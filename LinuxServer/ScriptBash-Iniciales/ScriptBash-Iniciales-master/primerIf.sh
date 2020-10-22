#!/bin/bash 
#if [condicion]; then 
#	acciones a ejecutar si la condicion es cierta
#fi
read -p "Introduce un número:" num1
read -p "Introduce un número:" num2
if [ $num1 -eq $num2 ]; then 
echo "Los numeros son iguales"
else 
echo "Los numeros son distintos"
fi



#Si (condicion) entonces = if [ ]; then
#	acciones a ejecutar si la condicion es cierta
#Si no = else
#	acciones a ejecutar si la condicion es falsa
#Fin del si = fi
