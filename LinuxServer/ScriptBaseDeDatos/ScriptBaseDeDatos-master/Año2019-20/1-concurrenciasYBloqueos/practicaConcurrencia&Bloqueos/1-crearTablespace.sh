#!/bin/sh
################################################################
# -------- EJ1. Creacion de un tablespace -------------------- # 
#Crea tablespace                                               #
# De nombrePARAOTROS.                                          #
# Con dos ficheros que se guardaran en ~/datos/paraotros.      #
# El tamaño de cada fichero sera como maximo de 100 MByte.     #
################################################################

# Accedemos al directorio donde crear el directorio 
cd /home/alumno  
# Creamos el directorio del tablespace  
mkdir datos/                   
# Creamos el tablespace en sqlplus como administrador.
#  |
#  + Asignamos un nombre al tablespace en este caso 'PARAOTROS'
#  + Escribimos la ruta donde se almacenará el datafile '/datos/paraotros1.dbf', 
#  | paraotros1.dbf es el tipo de archivo donde guarda mis datos del tablespace.
#  + Asignamos el tamaño INICIAL del tablespace, auto extenderse 'ON' con el siguiente tamaño '200k'
#  + Con tamaño maximo de 100M.
#
#  => Como nos pide que sea un tablespace pero con DOS ficheros DBF, creamos de la misma forma 'paraotros2.dbf'
# NOTA: IMPORTANTE terminar el tablespace con el punto y coma (;).

sqlplus / as sysdba<<EOF           
create tablespace paraotros       
datafile '/datos/paraotros1.dbf',
size 800k                                 
autoextend on                             
next 200k                                    
maxsize 100M,
'/datos/paraotros2.dbf'
size 800k                                 
autoextend on                             
next 200k                                    
maxsize 100M;                                
exit                               
EOF
