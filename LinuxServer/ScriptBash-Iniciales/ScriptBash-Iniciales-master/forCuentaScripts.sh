#!/bin/bash 
cont=0
for var in *
do
	if [ -x $var ] && [ -f $var ]; then
		cont=`expr $cont + 1`
	fi

done
 
	echo  La carpeta actual tiene  $cont scripts 
