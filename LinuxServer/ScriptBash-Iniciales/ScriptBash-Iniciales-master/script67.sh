#!/bin/bash 
resp=n
while [ $resp != s ] && [ $resp != S ]
do
read -p "Introduce un script: " scr

	while [ ! -f $scr ] || [ ! -x $scr ]
	do
		read -p "$scr no es un script. Introduce otro script: " scr
	done
	cat $scr
	read -p "Desea terminar? (s/n)" resp
done	
