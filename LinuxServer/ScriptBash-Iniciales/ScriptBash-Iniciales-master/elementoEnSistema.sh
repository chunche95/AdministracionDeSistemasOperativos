#!/bin/bash 

read -p "Introduce un elemento del sistema: " elem

#validacion
while [ ! -e $elem ]
do
	read -p "No se encuentra. Introduce un elemento del sistema: " elem
done

if [ -f $elem ]; then
	cat $elem
else
	ls $elem
fi	
