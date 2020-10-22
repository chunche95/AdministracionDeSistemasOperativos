#!/bin/bash

# Introducimos una cuota de 100k a CONPERMISOS para el tablespace USERS.
# Llenamos la cuota.

#########################################################################
# Para ver los usuarios de la base de datos usamos la sentencia SQL:    #
#  > select * from dba_users;                                           #
#########################################################################

echo drop user CONPERMISOS cascade;
sqlplus / as sysdba<<EOF

create user CONPERMISOS identified by CONPERMISOS
QUOTA 10k on Users;
grant connect, resource to CONPERMISOS;
exit
EOF

sqlplus CONPERMISOS/CONPERMISOS@10.1.35.51/asir<<EOF
create table DATOS(num integer);
begin
for i in 1..1000000 loop
insert into DATOS values(i);
end loop;
end;
/
commit;
select * from DATOS;
exit 
EOF
