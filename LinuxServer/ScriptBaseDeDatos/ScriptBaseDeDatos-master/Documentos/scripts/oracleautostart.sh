#!/usr/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c
ORACLE_SID=asir
PATH=$PATH:/home/alumno/oracle-install-18c/bin
export ORACLE_HOME
export ORACLE_SID

echo `date +%F-%T` - Solicitud de inicio Oracle >> /home/alumno/logs/oracle.log
oratab=`cat /etc/oratab | grep "asir:/home/alumno/oracle-install-18c:" | cut -d ":" -f3`

if [ $oratab = "N" ]
then
	echo `date +%F-%T` - Oracle no arranca, /etc/oratab indica N >> /home/alumno/logs/oracle.log
else
	echo `date +%F-%T` - Oracle arrancando, /etc/oratab indica Y >> /home/alumno/logs/oracle.log
	
	lsnrctl start
	ORACLE_SID=asir sqlplus / as sysdba <<EOF
		startup open
		exit
EOF
	echo `date +%F-%T` - Oracle arrancado >> /home/alumno/logs/oracle.log
fi

lsnrctl status
