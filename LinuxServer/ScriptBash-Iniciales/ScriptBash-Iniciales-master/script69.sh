#!/bin/bash 
apr=0
susp=0
for var in $*
do 
	if [ $var -ge 5 ]; then
	apr=`expr $apr + 1`
	else 
	susp=`expr $susp + 1`
	fi
	
done
echo Han aprobado $apr y suspendido $susp
