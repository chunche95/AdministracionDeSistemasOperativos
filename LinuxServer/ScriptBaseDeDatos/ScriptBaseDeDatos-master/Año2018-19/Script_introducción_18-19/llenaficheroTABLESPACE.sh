#!/bin/sh

sqlplus pau/pau1@192.168.1.140/asir<<EOF
begin 
for i in 1..20000
loop
insert into pruebas values('$i');
end loop;
end;
/
commit;
exit
EOF

ls -la
