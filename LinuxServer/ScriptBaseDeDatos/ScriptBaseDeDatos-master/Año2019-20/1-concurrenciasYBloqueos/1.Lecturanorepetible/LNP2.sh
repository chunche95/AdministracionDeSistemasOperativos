#!/bin/bash
ip1=$(hostname -I | cut -d ' ' -f '1')
date=$(date +%X-%x)
echo $date
echo ""
echo " SCRIPT USUARIO BLOQUEANTE -- INICIO"
echo ""
echo ""

sqlplus bloqueante/bloqueante@$ip1/asir<<EOF
-- +++++++++++++++++++++++++++++++++++++
-- + Inicio de la lectura no repetible +
-- +++++++++++++++++++++++++++++++++++++

set transaction isolation level
read commited

-- Lectura de la tabla sin cambios
select * from pruebas;
-- Cambios en numero 3
update pruebas set nombre='nom_1' where numero=3;
commit;
-- Cambios realizados
select * from pruebas where numero=3;
EOF

echo $date
echo "*********************************"
echo " SCRIPT USUARIO BLOQUEANTE -- FIN"
echo "*********************************"
echo ""