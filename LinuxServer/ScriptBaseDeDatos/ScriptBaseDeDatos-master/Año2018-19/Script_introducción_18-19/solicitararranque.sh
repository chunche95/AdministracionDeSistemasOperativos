#!/bin/sh
fecha=`date +%F-%T`
arrancar=`cat /etc/oratab | tail -1 | cut -d":" -f3`
echo "$fecha - Solicitud de arrancar Oracle" >> /home/alumno/logs/oracle.log

if [ $arrancar == N ];
then
	echo "$fecha - Solicitud de arranque de Oracle  fallida porque oratab = $arrancar"; 
else
	sh /home/alumno/scripts/oraclestart.sh
	echo "$fecha - Oracle arrancando porque /etc/oratab indica Y" >> ../logs/oracle.log

fi
echo "$fecha - Oracle arrancado " >> /home/alumno/logs/oracle.log
