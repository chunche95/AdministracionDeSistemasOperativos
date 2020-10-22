#!/bin/bash

ip1=$(hostname -I | cut -d ' ' -f '1')
rm archivos/user1.lst
sqlplus user1/user1@$ip1/asir<<EOF
spool archivos/user1
-- creacion de la tabla pruebas
create table pruebas(numero integer, nombre varchar(255));

-- Primeros datos
begin 
for i in 1 .. 3
loop
insert into PRUEBAS values(i, dbms_random.string('A',2));
end loop;
end;
/
commit;

set transaction isolation level
serializable;
select * from pruebas;
spool off
EOF