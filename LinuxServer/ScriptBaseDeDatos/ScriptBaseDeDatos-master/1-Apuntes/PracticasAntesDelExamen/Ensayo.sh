#!/bin/bash
# Cracion del fichero para el tablespace PRUEBAS
cd /home/alumno/
mkdir pruebas
# Tablespaces - tablespaces pruebas para usuario pruebas
sqlplus / as sysdba<<EOF
create tablespaces t_pruebas
datafile '/home/alumno/pruebas/pruebas.dbf'
autoextend on
next 200Kb
maxsize 15Mb;
EOF
# Usuarios - borrar/crear usuario PRUEBAS
sqlplus / as sysdba<<EOF
drop user pruebas cascade;
create user pruebas identified by pruebas
default tablespace t_pruebas
temporary tablespace t_pruebas
quota unlimited on pruebas
account unlock;
EOF
# Modificar usuarios PRUEBAS dar/quitar privilegios PRUEBAS
sqlplus / as sysdba<<EOF
grant connect, resource to pruebas;
grant create, drop to pruebas with grant option;
revoke drop to pruebas;
EOF
# Ver usuarios conectados
sqlplus / as sysdba<<EOF
SELECT username,
sid,
serial#
FROM v$session;
EOF
# ver usuarios creados en la base de datos y tienen privilegios de connect 
# sino ver la vista sobre la tabla ALL_USERS;
sqlplus / as sysdba<<EOF
select username from dba_users;
EOF
# Crear tabla DATOS del usuario PRUEBAS
sqlplus pruebas/pruebas@10.1.35.51/asir<<EOF
create table DATOS (usuario varchar(255), telefono integer(9), fecha date);
EOF
# Crear role r_pruebas con privilegios para usuario PRUEBAS
#  +--> dar privilegios (create, alter y drop)
#  +--> ver tablespaces
#  +--> hacer select en datos
#  +--> hacer un select para ver las tablas de usuario de Oracle
sqlplus / as sysdba<<EOF
create role r_pruebas;
grant create, alter, drop to r_pruebas;
grant select on DBA_TABLESPACE to r_pruebas;
grant select on DATOS to r_pruebas;
grant create view to r_pruebas;
grant select on user_tables to r_pruebas;
grant r_pruebas to pruebas;
EOF
# Ver la fecha de creación de una tabla alterando el rol r_pruebas
sqlplus / as sysdba<<EOF
grant select on user_objects to r_pruebas;
grant select on datos(telefono) to r_pruebas;
EOF
sqlplus pruebas/pruebas@10.1.35.51/asir<<EOF
select object_name, created from user_objects
where object_name = 'DATOS'
and 
object_type='table';
EOF

################################################################################
#  Para obtener todas las fechas de creación de todas las tablas del usuario:  #
# select object_name, created form user_objects
# where object_name in (select table_name from user_tables)
# and
# object_type = 'table'
# order by created desc; 
################################################################################

# Crear usuario EXAMEN
# Usuarios - borrar/crear usuario PRUEBAS
sqlplus / as sysdba<<EOF
drop user examen cascade;
create user examen identified by examen
default tablespace t_pruebas
temporary tablespace t_pruebas
quota unlimited on pruebas
account unlock;
grant connect, resource to examen;
EOF
# crear rol r_examen
sqlplus / as sysdba<<EOF
grant create role r_examen;
EOF
sqlplus pruebas/pruebas@10.1.35.51/asir<<EOF
create public synonym datos for pruebas.datos;
EOF
sqlplus / as sysdba<<EOF
grant select on datos to r_examen;
EOF
sqlplus pruebas/pruebas@10.1.35.51/asir<<EOF
alter table DATOS.TELEFONO default '667332151' not null check (telefono in (660539655,112,911,012));
EOF
# crear perfil para examen -> p_examen 
sqlplus / as sysdba<<EOF
create profile p_examen limit
session_per_user        2
cpu_per_session         unlimited
cpu_per_call            3000
connect_time            2
idle_time               3
logical_read_per_call   5
logical_read_per_session default
private_SGA             15k
composite_limit         5000000;
alter system set resource_limit=TRUE scope=BOTH;
alter user examen profile p_examen;

grant create synonym, drop public synonym to r_examen;
host echo "------------ASIGNACION DEL ROL AL USUARIO EXAMEN--------------"
grant r_examen to examen;
EOF
# Crear tabla DE10 para usuario EXAMEN y crear SYNONYM PUBLIC 
sqlplus examen/examen@10.1.35.51/asir<<EOF
create table DE10 usuario varchar(255), nota integer(2) default tablespace t_pruebas;
host echo "----------------------CREANDO SINÓNIMO DE LA TABLA----------------------------"
create public synonym DE10 for examen.DE10;
EOF
# Dar privilegios en las VISTAS DBA_ROLES,DBA_TABLESPACES
sqlplus / as sysdba<<EOF
grant select on DBA_ROLES to r_examen;
grant select on DBA_TABLESPACES to r_examen;
EOF
sqlplus examen/examen@10.1.35.51/asir<<EOF
begin
for i in 1 .. 5000000 loop 
insert into de10(usuario,nota) values('select dbms_random.string("A",10) from dual',EXEC dbms_random.seed(10));
end loop;
end;
/
EOF
# Privilegios para r_pruebas & creacion de BORRADOR.
sqlplus / as sysdba<<EOF
grant select on DBA_ROLE_PRIVS to r_pruebas;
grant select on dba_tab_privs to r_pruebas;
grant select on dba_tabs to r_pruebas;
grant r_pruebas to pruebas;
host echo "---------- CREANDO USUARIO BORRADOR ---------------"
create user borrador identifiedn by borrador;
grant connect, resource to borrador;
host echo "---- Dando permisos para alterar el campo nota a BORRADOR -----"
grant update(nota) on DE10 to borrador;
EOF
# Alterando tabla de la columna notas de la tabla DE10.
sqlplus examen/examen@10.1.35.51/asir<<EOF
alter table DE10 DEFAULT '1' NOT NULL CHECK(nota in(1,2,3,4,5,6,7,8,9,10));
EOF
# Pruebas bloquea la cuenta de BORRADOR
sqlplus pruebas/pruebas@10.1.35.51/asir<<EOF
alter user BORRADOR account lock;
EOF