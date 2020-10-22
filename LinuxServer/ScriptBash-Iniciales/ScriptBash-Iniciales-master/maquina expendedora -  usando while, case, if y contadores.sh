#!/bin/bash

cont=0

while [ $cont -eq 0 ]
do
	clear
	echo 'Elija una de las opciones:'
	echo -e '\e[34m 1. Agua          - 50 cents.'
	echo -e '\e[31m 2. Nuka Cola     - 200 cents.'
	echo -e '\e[93m 3. Fanta Naranja - 150 cents.'
	echo -e '\e[32m 4. 7 Up          - 150 cents.'
	echo -e '\e[0m 5. Salir'
	echo ''
	read -n1 -p 'Introduzca el número de su elección ' elecc
	echo ''
	echo ''

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
		5)
			echo ''
			echo 'Vuelva pronto'
			echo ''
			echo ''
			cont=1
			euro=0
			;;
		*)
			euro=0
			echo ''
			echo 'Elección no válida'
			echo ''
			echo ''
	esac

	echo ''
	echo ''

	if [ $euro -ne 0 ]; then

		read -p 'Introduzca la cantidad ' metido
		echo ''

		if [ $metido -lt $euro ]; then
			resto=`expr $euro - $metido`
			echo ''
			echo 'Ha elegido usted: '$mns' y le faltan '$resto' céntimos'

		elif [ $metido -eq $euro ]; then
			echo ''
			echo 'Perfecto, gracias'

		else
			resto=`expr $metido - $euro`
			echo ''
			echo 'Ha elegido usted: '$mns' y le sobran '$resto' céntimos'
		fi
	fi

sleep 3

done
