#!/bin/bash

ip1=$(hostname -I | cut -d ' ' -f '1')
rm archivos/p2.lst
sqlplus p2/p2@$ip1/asir<<EOF
spool archivos/p2
-- Nuevos datos fantasmas
begin 
for i in 1 .. 3
loop
insert into p1.PRUEBAS values(dbms_random.value(i,3), dbms_random.string('A',20));
end loop;
end;
/
commit;
EOF