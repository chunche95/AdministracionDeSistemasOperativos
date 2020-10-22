#!/bin/bash
servidor=10.1.0.228
fichero=muestra.img
fechahora=`date +%D" "%T`
usuario=ftpuser
password=ftpuser
fichlog=/tmp/traeftp.log
recodir=/tmp
echo " " >> $fichlog
echo " " >> $fichlog
echo ========================================================= >> $fichlog
echo Dia y hora de ejecucion: $fechahora >> $fichlog
echo ========================================================= >> $fichlog
ftp -inv $servidor <<EOF >> $fichlog 2>> $fichlog
	quote user $usuario
	quote pass $password
	lcd $recodir
	bin
	hash
	get $fichero
	bye
EOF
	
