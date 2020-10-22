#!/bin/bash 
read -p "Introduce un directorio: " di
cont=0
cd $di
for var in `ls`
do
	if [ -f $var ] && [ -x $var ]; then
	cont=`expr $cont + 1`
	fi
done
echo $di contiene $cont scripts
