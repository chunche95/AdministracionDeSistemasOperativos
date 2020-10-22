#!/bin/sh
ORACLE_HOME=/home/alumno/oracle-install-18c
ORACLE_SID=asir
PATH=$PATH:$ORACLE_HOME/bin/

export ORACLE_HOME
export ORACLE_SID

lsnrctl start

sqlplus / as sysdba <<EOF
startup open
EOF
sleep 5
clear
echo "----------------------------------------------"
hostname -I 
echo "----------------------------------------------"
sleep 5 
lsnrctl status
