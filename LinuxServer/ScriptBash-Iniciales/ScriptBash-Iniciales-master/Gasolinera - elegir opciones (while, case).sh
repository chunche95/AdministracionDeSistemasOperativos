#!/bin/bash

opc=0
while [ $opc -ne 5 ]
do
echo 'ELIJE TU COMBUSTIBLE'
echo ''
echo '1. Super95'
echo '2. Super98'
echo '3. Diesel'
echo '4. Diesel Plus'
echo '5. Salir'
echo ''
read -n1 -p 'Opción: ' opc
echo ''

case $opc in
	1)
		echo 'Has elegido Super95'
		;;
	2)
		echo 'Has elegido Super98'
		;;
	3)
		echo 'Has elegido Diesel'
		;;
	4)
		echo 'Has elegido Diesel Plus'
		;;
	5)
		echo 'FIN DEL COMUNICADO'
		;;
	*)
		echo 'Opción no válida'
		;;
esac
echo ''
echo ''
echo ''
done
