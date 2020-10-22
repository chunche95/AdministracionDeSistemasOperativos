#!/bin/bash
function instalado() {
	local PAQUETE=$1
	dpkg -l | grep $PAQUETE >>/dev/null
	case $? in
		0) echo s ;;
		*) echo n ;;
	esac
}

NUMINSTALADOS=0
for i in $*
	do
	case `instalado $i` in
		s) let NUMINSTALADOS=NUMINSTALADOS+1 ;;
	esac 
	done

case $NUMINSTALADOS in
	$#) echo Todos los paquetes instalados ; exit 0 ;;
	0) echo Ningun paquete instalado; exit 2 ;;
	*) echo Alguno de los paquetes no esta instalado; exit 1 ;; 
esac
