#!/bin/bash 
contFich=0
contDir=0
for var in $*
do

	if [ -f $var ]; then
		contFich=`expr $contFich + 1`
	elif  [ -d $var ]; then
		contDir=`expr $contDir + 1`
	fi
done
	if [ $contFich -gt $contDir ]; then
		echo Hay más ficheros que directorios
	elif  [ $contFich -lt $contDir ]; then
		echo Hay más directorios que ficheros
	else 
		echo Hay los mismos ficheros que directorios
	fi
