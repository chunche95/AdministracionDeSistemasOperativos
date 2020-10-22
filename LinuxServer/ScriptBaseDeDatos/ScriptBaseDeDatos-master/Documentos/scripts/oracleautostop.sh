#!/usr/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c
ORACLE_SID=asir
PATH=$PATH:/home/alumno/oracle-install-18c/bin
export ORACLE_HOME
export ORACLE_SID

echo `date +%F-%T` - Solicitud de inicio Oracle >> /home/alumno/logs/oracle.log

lsnrctl stop

ORACLE_SID=asir sqlplus / as sysdba <<EOF
	shutdown immediate
EOF

lsnrctl status

echo `date +%F-%T` - Oracle detenido >> /home/alumno/logs/oracle.log
