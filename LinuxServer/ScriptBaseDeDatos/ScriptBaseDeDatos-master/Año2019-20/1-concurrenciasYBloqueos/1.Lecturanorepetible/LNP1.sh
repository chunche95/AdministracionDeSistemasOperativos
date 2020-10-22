#!/bin/bash
ip1=$(hostname -I | cut -d ' ' -f '1')
date=$(date +%X-%x)
echo $date
echo ""
echo " SCRIPT USUARIO BLOQUEADO -- INICIO"
echo ""
echo ""

sqlplus bloqueado/bloqueado@$ip1/asir<<EOF
-- +++++++++++++++++++++++++++++++++++++
-- + Inicio de la lectura no repetible +
-- +++++++++++++++++++++++++++++++++++++

set transaction isolation level 
read commited 

-- 1ª lectura 
select * from pruebas;

host sleep 10
select * from pruebas;
EOF

echo $date
echo "********************************"
echo " SCRIPT USUARIO BLOQUEADO -- FIN"
echo "********************************"
echo ""