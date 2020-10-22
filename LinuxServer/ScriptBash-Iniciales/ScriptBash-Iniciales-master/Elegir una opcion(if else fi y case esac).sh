#!/bin/bash

echo 'Elija una de las opciones:'
echo -e '\e[34m 1. Agua          - 50 cents.'
echo -e '\e[31m 2. Nuka Cola     - 200 cents.'
echo -e '\e[93m 3. Fanta Naranja - 150 cents.'
echo -e '\e[32m 4. 7 Up          - 150 cents.'
echo -e '\e[0m'
read -n1 -p 'Introduzca el número de su elección ' elecc
echo ''

if [[ $elecc -gt 4  ||  $elecc -lt 1 ]]; then
	echo ''
	echo 'Elección no válida'
	echo ''
	echo ''
	./ejercicio2.sh

else
	case $elecc in
		1)
			echo -e 'Ha elegido usted \e[34mAgua\e[0m, debe introducir 50 céntimos'
			euro=50
			mns='Agua'
			;;
		2)
			echo -e 'Ha elegido usted \e[31mNuka Cola\e[0m, debe introducir 200 céntimos'
			euro=200
			mns='Nuka Cola'
			;;
		3)
			echo -e 'Ha elegido usted \e[93mFanta de Naranja\e[0m, debe introducir 150 céntimos'
			euro=150
			mns='Fanta de Naranja'
			;;
		4)
			echo -e 'Ha elegido usted \e[32m7 Up\e[0m, debe introducir 150 céntimos'
			euro=150
			mns='7 Up'
			;;
	esac

	read -p 'Introduzca la cantidad ' metido
	echo ''

	if [ $metido -lt $euro ]; then
		resto=`expr $euro - $metido`
		echo 'Ha elegido usted: '$mns' y le faltan '$resto' céntimos'

	elif [ $metido -eq $euro ]; then
		echo 'Perfecto, gracias'

	else
		resto=`expr $metido - $euro`
		echo 'Ha elegido usted: '$mns' y le sobran '$resto' céntimos'
	fi
fi
