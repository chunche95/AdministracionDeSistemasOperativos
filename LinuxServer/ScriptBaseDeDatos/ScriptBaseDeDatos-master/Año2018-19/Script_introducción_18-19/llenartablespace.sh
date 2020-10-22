#!/bin/sh

clear
# En este caso ya se ha creado el tablespace 'MITABLESPACE' con anterioridad.

# Creacion del usuario pepe y privilegios de conexion
sqlplus / as sysdba<<EOF
drop user pepe;
create user pepe identified by pepe1
default tablespace MITABLESPACE
quota unlimited on MITABLESPACE
account unlock;
grant connect to pepe;
grant resource to pepe;
grant select,insert,update,delete on kk to pepe;
exit
EOF

# conectamos con el usuario pepe para llenar el tablespace
# create table MITABLA(varchar(1024)) tablespace MITABLESPACE;
sqlplus pepe/pepe1@10.1.35.51/asir<<EOF

create table MiTabla(MiValor varchar(1024)) tablespace MITABLESPACE;

begin
for i in 1..10000 loop
insert into MiTabla values('texto de prueba');
end loop;
end;
/
commit;
EOF