#!/bin/bash 
cont=0
for var in `cat $1`
do
	if [ $var = $2 ]; then
		cont=`expr $cont + 1`
	fi

done
if [ $cont -gt 0 ]; then 
	echo $2 aparece $cont veces en $1
else
	echo $2 no aparece en $1
fi
