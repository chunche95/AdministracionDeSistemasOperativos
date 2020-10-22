#!/bin/sh

sh variables.sh

lsnrctl start
echo "Listener hecho!"
sqlplus / as sysdba <<EOF
startup open
EOF
echo "Estancia hecha!"

lsnrctl status