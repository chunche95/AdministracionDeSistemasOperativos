#!/bin/bash

# Script de ejecucion de lectura no repetible en SQLPlus
# Machine: Centos 7 - Oracle 18c
# ===================================================================
# Ejecucuión de 2 conexiones simultáneas:
# + Creación de usuarios (BLOQUEADO & BLOQUEANTE) y privilegios
# + Creación de la tabla de pruebas 
# + Asignación del privilegio de actualizar una tabla a BLOQUEANTE
# + Ejecución de los scripts de ambos usuarios
# + 
# ===================================================================
# NOTAS:
# ===================================================================
# Activar la hora en SQLPlus -> set time on
# Activar el tiempo de ejecución de una consulta --> set timi on
# Activar la cantidad de filas afectadas por cada consulta --> set feedback on
# Muestra cada consulta que se ejecuta --> set echo on
# 
###########################################################################
#                               ESQUEMA
###########################################################################
# -- +++++++++++++++++++++++++++++++++++++
# -- + Inicio de la lectura no repetible +
# -- +++++++++++++++++++++++++++++++++++++
#           (1)                                            (2)
#
#   set transaction isolation level           set transaction isolation level
#   read commited                             read commited
# ------------------------------------------------------------------------------
#   -- 1ª lectura                             -- Lectura de la tabla sin cambios
#   select * from pruebas;                    select * from pruebas;
#                         -- Cambios en numero 3
#                                             update pruebas set nombre='nom_1' where numero=3;
#                                             commit;
#                       -- Veo más información ahora. en (1)
#   select * from pruebas;    
#   rollback

clear
echo "Borrando SALIDA.LST"
rm salida.lst
sleep 2
clear 
# Creacion de usuarios de prueba
sqlplus / as sysdba<<EOF
set time on
set timi on
set feedback on
set echo on
host echo '-------------------------------------'

spool salida
drop user bloqueado cascade;
drop user bloqueante cascade;
create user bloqueado identified by bloqueado QUOTA unlimited on users default tablespace USERS;
grant connect, resource to bloqueado;
grant create synonym to bloqueado;
alter user bloqueado quota unlimited on users;
-- ------------------------------------------------------
host echo 'Usuario y privilegios otorgados a BLOQUEADO'
-- ------------------------------------------------------
create user bloqueante identified by bloqueante;
grant connect, resource to bloqueante;
host echo '--------------------------------------------'
host echo 'Usuario y privilegios otorgados a BLOQUEANTE'
host echo '--------------------------------------------'
exit
spool off
EOF
# Movemos el archivo de salida de SQL a la carpeta de archivos
sleep 5
fecha=$(date +%H:%M-%A-%d_%B_%Y)
echo ""
echo $fecha
echo ""
echo "Copiando archivo de salida a carpeta de archivos"
cp salida.lst archivos/salida_$fecha.lst
echo $?
sleep 5
if [ $? -eq 0 ]; then
echo -e "\e[32m         Copiado...[X] \e[0m"
else
echo -e "\e[31m         Hay un error al copiar el archivo [X] \e[0m"
fi
sleep 5 
clear
rm salida.lst
echo ""
echo -e "\e[44m----------------------------------------- \e[0m"
echo -e "\e[34m    Ejecución de los SCRIPT DE USUARIOS   \e[0m"
echo -e "\e[44m----------------------------------------- \e[0m"
echo ""

# Script de usuario 1
sh bloq1.0.1.sh >>archivos/salidaScript_$fecha.lst
echo -e "\e[36m OKY \e[0m"

# SQLPLUS SYS
sqlplus / as sysdba<<EOF
set time on
-- Creación de sinónimo de la tabla pruebas.
create or replace public synonym pruebas for bloqueado.pruebas;
-- ---------------------------------------------------------------------------
-- Permiso para actualizar filas/columnas de usuario bloqueado a bloqueante --
-- ---------------------------------------------------------------------------
grant update on bloqueado.pruebas to bloqueante;
grant select on bloqueado.pruebas to bloqueante;
EOF
echo -e "\e[36m OKY \e[0m"

# Script de usuario 2
sh bloq1.0.2.sh >>archivos/salidaScript_$fecha.lst
echo -e "\e[36m OKY \e[0m"
sleep 5
clear 
rm archivos/LECTURA-NO-REPETIBLE.lst 
# Por último,lanzamos los script de comprobación de  LECTURA NO REPETIBLE.
sh LNP1.sh >>archivos/LECTURA-NO-REPETIBLE.lst 
sh LNP2.sh >>archivos/LECTURA-NO-REPETIBLE.lst
echo -e "\e[36m Script ejecutados \e[0m"
clear

cat archivos/LECTURA-NO-REPETIBLE.lst
echo -e "ESTADO DE SCRIPT: \e[32m TERMINADO \e[0m"
sleep 5
clear