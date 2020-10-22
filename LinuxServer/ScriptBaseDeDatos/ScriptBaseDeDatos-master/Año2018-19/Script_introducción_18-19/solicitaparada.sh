#!/bin/sh
fecha=`date +%F-%T`

	echo "$fecha - Solicitud de parar Oracle" >> ../logs/oracle.log
	echo "$fecha - Oracle parando " >> ../logs/oracle.log
	sh /home/alumno/scripts/oraclestop.sh
	echo "$fecha - Oracle arrancado " >> ../logs/oracle.log
