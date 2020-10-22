#!/bin/sh

sh variables.sh

lsnrctl stop
echo "Listener parado!"
sqlplus / as sysdba <<EOF
shutdown immediate
EOF
echo "Estancia parada!"

lsnrctl status