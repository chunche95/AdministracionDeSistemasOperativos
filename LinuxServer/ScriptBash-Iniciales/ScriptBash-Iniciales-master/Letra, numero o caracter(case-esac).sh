#!/bin/bash

read -n1 -p 'Introduzca el carácter ' carac
echo ''

case $carac in
	[A-Z])
		echo 'Es una letra'
		;;
	[0-9])
		echo 'Es un número'
		;;
	*)
		echo 'No es número ni letra'
		;;
esac
