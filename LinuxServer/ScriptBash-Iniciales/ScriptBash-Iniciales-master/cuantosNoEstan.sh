#!/bin/bash 
cont=0
for var in $*
do
	if [ ! -e $var ]; then
		cont=`expr $cont + 1`
	fi
done
echo $cont parámetros no son del sistema
