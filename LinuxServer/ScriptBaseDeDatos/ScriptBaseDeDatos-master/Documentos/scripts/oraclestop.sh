#!/usr/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c
ORACLE_SID=asir
PATH=$PATH:$ORACLE_HOME/bin/

export ORACLE_HOME
export ORACLE_SID

lsnrctl stop

sqlplus / as sysdba <<EOF
shutdown immediate
EOF

lsnrctl status
