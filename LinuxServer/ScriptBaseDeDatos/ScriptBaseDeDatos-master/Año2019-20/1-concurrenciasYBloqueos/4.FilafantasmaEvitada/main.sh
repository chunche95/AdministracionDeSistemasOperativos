#!/bin/bash


# Script de ejecución de fila fantasma evitada 
# Machine: Centos7 - Oracle 18c
# ============================================================================================
# Ejecución de 2 conexiones simultaneas
# + Usuarios p1  & p2
# + Tabla PRUEBAS de p1
# + p2 inserta datos y los guarda
# + PERO LOS CAMBIOS NO SE VEN 
# + Si p1 hace cambios SALTA ERROR: ORA-08177
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
#  -----------------   INSERTAMOS  DATOS   ---------------------------------------------------
#                                       insert into pruebas values (i, 'DATOS FANTASMA EVITADOS');
#                                       commit;
# select * from pruebas;  
# -------------- (1) NO VE CAMBIOS EN LOS DATOS, DATOS ACTUALIZADOS -------------------------------
# -------------- PERO SI CAMBIA DATOS USER1 SALTA UN ERROR ORA-08177 ------------------------------
# delete from pruebas where numero=3;
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

-- user p1
drop user p1 cascade;
create user p1 identified by p1;
grant connect, resource to p1;
alter user p1 quota unlimited on users;

-- creacion de la tabla pruebas
host sh p1.sh 

-- user p2
drop user p2 cascade;
create user p2 identified by p2;
grant connect, resource to p2;
grant update on p1.pruebas to p2; 
grant insert on p1.pruebas to p2; 

-- Cambiamos datos
host sh p2.sh

-- Cambiamos datos en usuario 1
host sh p1.1.sh