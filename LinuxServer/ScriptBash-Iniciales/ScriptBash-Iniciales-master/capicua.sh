#!/bin/bash 
read -p "Introduce un número de 3 digitos: " num

#numero de 3 digitos por lo tanto esta comprendido entre 100 y 1000

if [ $num -ge 100 ] && [ $num -lt 1000 ]; then
#capicua comparando la centena y unidad obtenidas del cut
	centena=`echo $num | cut -c 1`
	unidad=`echo $num | cut -c 3`
	if [ $centena -eq $unidad ]; then
		echo $num es capicúa
	else
		echo $num no es capicúa
	fi

#capicua comparando la centena y unidad obtenidas de operaciones matematicas
	centena2=`expr $num / 100`
	unidad2=`expr $num % 10`
	if [ $centena2 -eq $unidad2 ]; then
		echo $num es capicúa
	else
		echo $num no es capicúa
	fi
else
	echo $num no tiene 3 digitos
fi


