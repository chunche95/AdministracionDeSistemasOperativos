#!/bin/bash

# Script de ejecución de fila fantasma en SQLPlus 
# Machine: Centos7 - Oracle 18c
# ============================================================================================
# Ejecución de 2 conexiones simultaneas
# + Usuarios Person & Gosht
# + Tabla PRUEBAS de Person
# + Ghost inserta datos y los guarda
# + Person ve su tabla de nuevo y tiene nuevos datos
# + 
# + EJECUTAR GHOSTFILE.SH
# +---> Ejecuta TablePerson.sh ---> Crea archivos/person.lst
# +---> Ejecuta DataGhost.sh -----> Crea archivos/ghost.lst
# +---> Ejecuta ReadNewdata.sh ---> Añade contenido a person.lst
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
# set transaction isolation level       set transaction isolation level
# read commit                           read commit
# select * from pruebas;                
#  ----------------- INSERTAMOS NUEVOS DATOS ---------------------------------------------------
#                                       insert into pruebas values('nuevos datos', 'fantasma')
#                                       commit;
# -------------- (1) VE MÁS DATOS QUE EN LA PRIMERA LECTURA ------------------------------------
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
set time on
set echo on
spool archivos/main

-- Usuario person & permisos
drop user person cascade;
create user person identified by person;
grant connect, resource to person;
alter user person default tablespace USERS quota unlimited on USERS;
grant create synonym to person;

-- Creación de la tabla PRUEBAS
host sh TablePerson.sh

-- Creacion del sinónimo de PRUEBAS
create or replace public synonym pruebas for person.pruebas;

-- Usuario ghost & permisos
drop user ghost cascade;
create user ghost identified by ghost;
grant connect, resource to ghost;
grant insert, delete, update on person.pruebas to ghost;

-- Insert de datos en la tabla pruebas.
host sh DataGhost.sh 

-- Lectura de los nuevos datos
host sh ReadNewData.sh
spool off
EOF

# Fin del script principal 
echo "Fin del script - Ejecución Finalizada."