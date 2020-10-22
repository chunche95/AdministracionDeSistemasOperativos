#!/bin/bash
opcion=1
clear 
	while [ ! $opcion -eq 4 ] && true ;
	do
	echo 1. Comprobar si se puede escribir el archivo /etc/hosts
	echo 2. Realizar un fichero .tar con todos los ficheros de /etc
	echo 3. Averiguar espacio ocupado por cada uno de los subdirectorios de /
	echo 4. Salir
	read -p "Pulsa una opcion: " opcion
	case $opcion in
		1) test -w /etc/host && echo Se puede; read nada;; 
		2) 	read -p "Introducir nombre del archivo resultado: " emp
			tar -cvf $emp /etc
			;;
		3) du -sh /* 2> /dev/null; read nada;;
	esac
	done
echo

