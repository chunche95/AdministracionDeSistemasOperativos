#!/bin/bash

ip1=$(hostname -I | cut -d ' ' -f '1')
rm archivos/p1.lst
sqlplus p1/p1@$ip1/asir<<EOF
spool archivos/p1
-- creacion de la tabla pruebas
create table pruebas(numero integer, nombre varchar(255));

-- Primeros datos
begin 
for i in 1 .. 10
loop
insert into PRUEBAS values(i, dbms_random.string('A',2));
insert into PRUEBAS values(i-2, dbms_random.string('A',5));
end loop;
end;
/
commit;

set transaction isolation level serializable;
select * from pruebas;
EOF