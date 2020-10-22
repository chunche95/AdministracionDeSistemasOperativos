#!/bin/bash 
fecha=` date +%B `
mes="abril"
if [ $fecha == $mes ]; then
	echo Estamos en el mes de abril
else 
	echo No estamos en el mes de abril
fi

