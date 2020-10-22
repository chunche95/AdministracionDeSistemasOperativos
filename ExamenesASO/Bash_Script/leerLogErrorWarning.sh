#!/bin/bash
echo ""
ruta=/var/log/syslog
echo "Ruta por defecto: "$ruta
sleep 2
if [ -z $1 ]; then
	echo "Falta introducir el fichero como parámetro..."
	echo ""
	read -p "¿Seguro NO quiere introducir un fichero? (s/n) ... Procederemos a realizar la busqueda en la ruta por defecto del sistema: " respuesta
	grep -wine "fallo" -wine "aviso" -wine  "error"  -wine "warning" -wine  "fail" -wine  "panic" $1 | head
	if [ $respuesta=='s' ]; then
		echo -e "Vale, sin problema...Buscando en $ruta "
		echo "Buscando en el fichero por defecto del sistema: /var/log/syslog "
		echo "Resultados: "
		echo " |	| "
		echo " V	V "
		echo "		  "
		grep -wine "fallo" -wine "aviso" -wine "error" -wine "warning" -wine "fail" -wine "panic" /var/log/syslog >> Salida.txt
		echo ""
		echo "Tiene un fichero de salida con el resultado al completo"
	elif [ $respuesta=='n' ];then
		read -p "Introduzca el parametro de entrada " $fich
			if [ -f $fich  ]; then
				echo -e "Fichero encontrado!"
				echo -e "-------------------"
				echo -e "Estamos buscando las palabras (fallo, aviso, error, warning, fail o panic) ... Por favor espere."
				echo -e ""
				echo "Buscando en el fichero: $1 "
				echo "Resultados: "
				echo " |	| "
				echo " V	V "
				echo "		  "
				echo -e ""
				grep -wine "fallo" -wine "aviso" -wine "error" -wine "warning" -wine "fail" -wine "panic" $fich >> Salida.txt
				grep -wine "fallo" -wine "aviso" -wine "error" -wine "warning" -wine "fail" -wine "panic" $fich | head 
				echo ""
				echo "Tiene un fichero de salida con el resultado al completo"

			else
				echo -e "Fichero de entrada no existe"
			fi
	else
		echo "Se ha producido un error en la ejecucion del programa, por favor, vuelva a iniciarlo, gracias. "	
	fi
else
	echo "Buscando en el fichero: $1 "
	echo "Resultados: "
	echo " |	| "
	echo " V	V "
	echo "		  "
	grep -wine "fallo" -wine "aviso" -wine  "error"  -wine "warning" -wine  "fail" -wine  "panic" $1 >> Salida.txt
	grep -wine "fallo" -wine "aviso" -wine  "error"  -wine "warning" -wine  "fail" -wine  "panic" $1 | head
	echo ""
	echo "Tiene un fichero de salida con el resultado al completo"

fi
