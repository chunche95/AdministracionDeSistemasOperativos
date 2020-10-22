#!/bin/bash

ip=$(hostname -I | cut -d ' ' -f '1')
date
echo "CREACION DE LA TABLA PRUEBAS."
echo ""

# Borramos el log anterior
rm archivos/person1.lst

# Lanzamos el script
sqlplus person/person@$ip/asir<<EOF
-- Creación de la tabla pruebas
spool archivos/person1
drop table PRUEBAS;
create table PRUEBAS(numero integer, nombre varchar(255));
begin 
for i in 1 .. 3
loop
insert into PRUEBAS values(i, dbms_random.string('A',5));
end loop;
end;
/
commit;
set transaction isolation level;
read commited;
select * from pruebas;
EOF

# Fin del script 
echo ""
echo "Script Person finalizado"
echo ""