#!/bin/bash
ip=$(hostname -I | cut -d ' ' -f '1')

# Borramos el log antigüo
rm archivos/ghost.lst

# Lanzamos el script
sqlplus ghost/ghost@$ip/asir<<EOF
spool archivos/ghost
set transaction isolation level;
read commited;
begin 
for i in 1 .. 10
loop
insert into person.pruebas values(i, 'Nuevo dato fantasma');
end loop;
end;
/
commit;
EOF

# Fin del script 
echo ""
echo "Script fantasma finalizado"
echo ""