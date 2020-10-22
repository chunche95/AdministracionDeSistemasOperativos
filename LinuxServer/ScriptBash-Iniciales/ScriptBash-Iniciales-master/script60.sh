#!/bin/bash 
if [ $# -eq 2 ]; then
	contCarp1=0
	contCarp2=0
	cd $1
	for var in *
	do
		if [ -f $var ]; then
			contCarp1=`expr $contCarp1 + 1`
		fi
	done
	cd ../$2
	for var in *
	do
		if [ -f $var ]; then
		contCarp2=`expr $contCarp2 + 1`
		fi
	done
	 if [ $contCarp1 -gt $contCarp2 ]; then
		echo $1 contiene más ficheros que $2
	elif [ $contCarp1 -lt $contCarp2 ]; then
		echo $2 contiene más ficheros que $1
	else
		echo $1 y $2 contienen los mismos ficheros
	fi
		
else
	echo Nºparametros incorrecto
fi
