#!/bin/bash 
cont=0
for var in `cut -d":" -f1 /etc/passwd`
do
	cont=`expr $cont + 1`
	
done
echo Hay $cont usuarios en el sistema
