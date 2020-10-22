#!/bin/bash 
read -p "Introduce un número: " num
esPar=`expr $num % 2`
if [ $esPar -eq 0 ]; then
	echo $num es par
else 
	echo $num es impar
fi

esPar2=$(($num % 2))
if [ $esPar -eq 0 ]; then
	echo $num es par
else 
	echo $num es impar
fi

