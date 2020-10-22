#!/bin/bash

#   Imagina que
#       Creas un rol con sus permisos
#       Le asignas privilegios
#       Lo asignas al usuario USUARIOANTES
#       Quitas algún privilegio del rol
#       Asignas el rol al usuario USUARIODESPUES
#   El usuario USUARIODESPUES, ¿tiene más, menos o los mismos privilegios que USUARIOANTES?
#       O lo que es lo mismo, ¿los permisos del rol se copian al usuario o se enlazan?
#
clear

# Creo usuarios
sqlplus / as sysdba<<EOF
drop user USUARIOANTES cascade;
drop user USUARIODESPUES cascade;

create user USUARIOANTES identified by USUARIOANTES;
create user USUARIODESPUES identified by USUARIODESPUES;

alter user USUARIOANTES quota UNLIMITED on USERS;

grant connect, resource to USUARIOANTES;
grant connect, resource to USUARIODESPUES;
EOF

# Conecto con usuarioantes y creo tabla
sqlplus USUARIOANTES/USUARIOANTES@10.1.35.51/asir<<EOF
create table MITAB(DATOS varchar(255));
insert into MITAB values('datos de pruebas');
commit;
EOF

sqlplus / as sysdba<<EOF
drop role PERMISOS;
create role PERMISOS;
grant select,insert,update on USUARIOANTES.MITAB to PERMISOS;

grant PERMISOS to USUARIOANTES;
grant PERMISOS to USUARIODESPUES;
EOF

sqlplus USUARIODESPUES/USUARIODESPUES@10.1.35.51/asir<<EOF
select * from USUARIOANTES.MITAB;
update USUARIOANTES.MITAB SET datos='Actualizando datos antes';
exit
EOF

sqlplus / as sysdba<<EOF
revoke update on USUARIOANTES.MITAB from PERMISOS;
EOF

sqlplus USUARIODESPUES/USUARIODESPUES@10.1.35.51/asir<<EOF
update USUARIOANTES.MITAB SET datos='Actualizando datos después';
select * from USUARIOANTES.MITAB;
exit
EOF
