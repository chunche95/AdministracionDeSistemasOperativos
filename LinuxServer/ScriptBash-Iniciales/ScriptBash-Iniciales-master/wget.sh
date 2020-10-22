#!/bin/bash
servidor=10.1.0.228
fichero=muestra.img
fechahora=`date +%D" "%T`
wget --connect-timeout=30 http://$servidor/$fichero &> /dev/null
	case $? in 
		0)echo $fechahora Fichero recogido OK >> wget.log ;;
		1)echo $fechahora Error generico >> wget.log ;;
		2)echo $fechahora Error parseo .wgetrc o .netrc >> wget.log ;;
		3)echo $fechahora Error de entrada\/salida >> wget.log ;;
		4)echo $fechahora Error de red >> wget.log ;;
		5)echo $fechahora Error de verificacion SSL >> wget.log ;;
		6)echo $fechahora Error de autenticacion usuario\/password >> wget.log ;;
		7)echo $fechahora Error de protocolo >> wget.log ;;
		8)echo $fechahora Respuesta fallida del servidor >> wget.log ;;
	esac
