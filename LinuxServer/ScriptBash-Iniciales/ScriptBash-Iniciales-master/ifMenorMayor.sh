#!/bin/bash 
#if [condicion]; then 
#	acciones a ejecutar si la condicion es cierta
#fi
read -p "Introduce tu edad:" num1
if [ $num1 -ge 18 ]; then 
echo "Eres mayor de edad"
else 
echo "Eres menor de edad"
fi



#Si (condicion) entonces = if [ ]; then
#	acciones a ejecutar si la condicion es cierta
#Si no = else
#	acciones a ejecutar si la condicion es falsa
#Fin del si = fi
