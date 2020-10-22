#!/bin/bash
echo ''
cont=1
if [ $# -eq 1 ]; then
	echo 'VAMOS A HACER LA TABLA DEL: '$1
	echo ''
	while [ $cont -le 10 ]
	do
		multi=`expr $1 \* $cont`
		echo $1' x '$cont' = '$multi
		cont=`expr $cont + 1`
	done
else
	echo 'Debes introducir un solo parámetro'
fi

echo ''
echo ''
