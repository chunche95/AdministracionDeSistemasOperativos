#!/bin/bash

# Script de ejecución de lectura no repetible evitada
# Machine: Centos7 - Oracle 18c
# ============================================================================================
# Ejecución de 2 conexiones simultaneas
# + Usuarios user1 & user2
# + Tabla PRUEBAS de user1
# + user 2 actualiza datos
# + PERO LOS CAMBIOS NO SE VEN PORQUE FALTA EL COMMIT
# +  y los guarda, pero aun asi NO ve los cambios user1.
# +
#
# =============================================================================================
# NOTAS:
# =============================================================================================
# Activar la hora en SQLPlus -> set time on
# Activar el tiempo de ejecución de una consulta --> set timi on
# Activar la cantidad de filas afectadas por cada consulta --> set feedback on
# Muestra cada consulta que se ejecuta --> set echo on
# 
# =============================================================================================
#                          ESQUEMA
# ==============================================================================================
#       (1)                                     (2)
# set transaction isolation level       
# serializable                          
#  -----------------   ACTUALIZAMOS  DATOS   ---------------------------------------------------
#                                       update pruebas set nombre='SERIALIZABLE' where numero=3;
# select * from pruebas;  
# -------------- (1) NO VE CAMBIOS EN LOS DATOS  -----------------------------------------------
#                                       commit;
# -------------- (1) NO VE CAMBIOS EN LOS DATOS, DATOS ACTUALIZADOS ----------------------------
# select * from pruebas;
# rollback;
#
clear
# Crear carpeta
mkdir archivos
# Borrar archivo log principal
rm archivos/main.lst

# Lanzamos los scripts
sqlplus / as sysdba<<EOF
spool archivos/main
-- user1
drop user user1 cascade;
create user user1 identified by user1;
grant connect,resource to user1;
alter user user1 quota unlimited on users;

-- creacion de la tabla pruebas
host sh user1.1.sh

-- user2
drop user user2 cascade;
create user user2 identified by user2;
grant connect,resource to user2;
grant select on user1.pruebas to user2;
grant update on user1.pruebas to user2;

-- actualiza datos user2
host sh user2.1.sh

-- Realiza lectura de datos user1 
connect user1/user1
select * from pruebas;


-- Guardo los cambios de user2 
host sh user2.2.sh


-- Vuelve user1 a ver los datos y NO ve los cambios (HAY BLOQUEO)
host sleep 5
show user;
select * from pruebas;

spool off
EOF