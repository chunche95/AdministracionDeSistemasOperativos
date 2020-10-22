#!/bin/bash 
read -p "Saluda: " saludo
case $saludo in 
	hola)
		echo hola que tal
		;;
	adios)
		echo hasta luego
		;;
	*)
		echo no entiendo tu saludo
		;;
esac

echo fin del programa
