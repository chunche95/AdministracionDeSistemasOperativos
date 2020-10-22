#!/bin/bash

#
#   Crea un usuario CONPERMISOS
#       Que tenga privilegios de connect y resource
#       Utilízalo para crear una tabla DATOS(TEXTO varchar2(255),numero integer)
#       Inserta datos (puede que necesite cuota)
#   Crea un usuario LIMITADO
#   Haz que CONPERMISOS de privilegios a LIMITADO para que:
#       Pueda leer todos los campos de la tabla DATOS
#       Pueda actualizar el campo NUMERO de tabla DATOS
#       Pero no pueda modificar el campo TEXTO, ni borrar filas, ni insertar filas
#


# Accedemos a la carpeta de tablespaces.
cd /home/alumno/tablespace

# Creamos usuarios CONPERMISOS & LIMITADO
sqlplus / as sysdba<<EOF
create tablespace DISKCONPERMISOS
datafile '/home/alumno/tablespace/tablespaceconpermisos.dbf'
size 100k
autoextend on
next 50k 
maxsize 200k;

drop user CONPERMISOS cascade;
create user CONPERMISOS identified by CONPERMISOS
default tablespace DISKCONPERMISOS
quota unlimited on DISKCONPERMISOS
account unlock;
grant connect, resource to CONPERMISOS;

drop user LIMTADO cascade;
create user LIMITADO identified by LIMITADO;
grant connect, resource to LIMITADO;
exit
EOF

# Accedemos al usuario con permisos para crear la tabla datos 
sqlplus CONPERMISOS/CONPERMISOS@10.1.35.51/asir<<EOF
drop table datos;
create table DATOS(TEXTO varchar(255), NUMERO integer);
begin
for i in 1..10 loop
insert into DATOS values('mitexto',1);
end loop;
end;
/
commit;
grant select on datos to limitado;
grant update (numero) on datos to limitado;
exit
EOF

sqlplus LIMITADO/LIMITADO@10.1.35.51/asir<<EOF
select * from conpermisos.datos;
update conpermisos.datos set numero='2';
update conpermisos.datos set texto='TURURU';
select * from conpermisos.datos;
exit
EOF

