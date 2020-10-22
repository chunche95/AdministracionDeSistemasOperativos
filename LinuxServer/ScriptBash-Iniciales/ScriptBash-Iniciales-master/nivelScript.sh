#!/bin/bash 
read -p "Introduce un script: " scr
#validacion
while [ ! -f $scr ] || [ ! -x $scr ]
do
	read -p "No es un script, introduce otro valor: " scr
done

#que nivel tiene el script
lineas=`cat $scr | wc -l`
if [ $lineas -lt 10 ]; then 
	echo $scr es un script fácil
elif [ $lineas -le 20 ]; then
	echo $scr es un script nivel medio
else 
	echo $scr es un script difícil
fi
