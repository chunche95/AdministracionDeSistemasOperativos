#!/bin/bash
ip1=$(hostname -I | cut -d ' ' -f '1')
ip2=$(hostname -I | cut -d ' ' -f '1')
ip3=$(hostname -I | cut -d ' ' -f '1')
clear
# Sentencias realizadas por usuario bloqueado
echo "      SCRIPT 1        "
echo "-------------------------------------"
echo $ip1
echo "-------------------------------------"

sqlplus bloqueado/bloqueado@$ip1/asir<<EOF
-- Creación de la tabla pruebas
drop table PRUEBAS;
create table PRUEBAS(numero integer, nombre varchar(255));
begin 
for i in 1 .. 10 
loop
insert into PRUEBAS values(i, dbms_random.string('A',5));
end loop;
end;
/
commit;
select * from pruebas;

host echo '---------------'
show user;
host echo '---------------'
host echo '+++++++++++++++'
host echo '|||||||||||||||'
host echo '|||||||||||||||'
host echo 'vvvvvvvvvvvvvvv'
host sleep 2


EOF
sleep 5
clear
echo "-------------------------------------"
echo "          SCRIPT 1.0 TERMINADO         "
echo "-------------------------------------"
echo ""
echo ""
echo ""