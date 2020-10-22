#!/bin/bash

var=0
while [ $var -eq 0 ]
do

	read -p 'Instroduzca el usuario ' usu
	existe=`cut -d":" -f1 /etc/passwd | grep $usu$ | wc -l`

	if [ $existe -eq 1 ]; then
		echo '/home/'$usu
		var=1
	else
		echo 'El usuario no existe'
	fi

done
