#!/bin/bash 
#un script se comporte como el comando mv (que mueva el origen al destino o renombre y que necesite al menos 2 parametros)
if [ -d $2 ]; then 
	`mv $1 $2`
	echo $1 ha sido movido a $2
else
	`mv $1 $2`
	echo $1 ha sido renombrado como $2
fi
