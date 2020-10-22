#!/bin/sh  

############################################################################################################
# Ejercicio 4 : Creacion de las tablas.                                                                    #
#                                                                                                          #
# Cambia la contraseña de tu usuario, si no lo has hecho ya, para que ningun compañero pueda utilizarlo    #
# (conALTER USER).                                                                                         #
# 1. Crea un tablespacede nombre CARRERAS, con un datafile en el directorio /datos/carreras.               #
# 2. Con tu propio usuario, crea las tablas en ese tablespace.                                             #
#  2.1 Utiliza el script carreras-coches.sql para la creación de las tablas.                               #
#  2.2 Tendrás que modificar elscript para que tenga en cuenta el nuevo tablespace                         #
############################################################################################################

# Accedemos al directorio donde crear el directorio
cd /home/alumno
# Creamos el directorio del tablespace
mkdir datos/carreras  
# Creamos el tablespace en sqlplus con SYS.
sqlplus / as sysdba<<EOF 
drop tablespace carreras;
create tablespace carreras  
datafile '/datos/carreras/carreras.dbf'  
size 800k                
autoextend on                  
next 200k 
maxsize 100M;   
alter user BERMUDEZ default tablespace carreras quota unlimited on carreras;
exit      
EOF 
# Lanzamos el script de carreras de SQL con BERMUDEZ Modificado para que almacene las tablas en el TABLESPACE CARRERAS.
sqlplus BERMUDEZ/BERMUDEZ51@10.1.35.51/asir @carreras-coches.sql
exit
