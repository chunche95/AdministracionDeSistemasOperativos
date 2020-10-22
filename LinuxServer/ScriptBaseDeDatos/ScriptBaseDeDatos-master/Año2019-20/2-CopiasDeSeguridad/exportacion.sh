#!/bin/bash
clear

# Folder save datafiles
# Folder import
mkdir /home/alumno/Documents/SccriptsBaseDeDatos/BackUps/Omen
# Folder exportation
mkdir /home/alumno/Documents/SccriptsBaseDeDatos/BackUps/Pauchino

# Export
sqlplus / as sysdba<<EOF
drop user usuariopruebas cascade;

create tablespace tablespacepruebas
datafile '/home/alumno/datos/tablespacepruebas.dbf'

create user usuariopruebas identified by usuariopruebas 
default tablespace tablespacepruebas
quota unlimited on tablespacepruebas;

grant connect, resource to usuariopruebas;
create any directory directorypruebas as '/home/alumno/datos';

grant read, write on directorypruebas to usuariopruebas;

grant exp_full_database to usuariopruebas;
EOF

# Eject Data SQL 
sqlplus usuariopruebas/usuariopruebas@10.1.35.51/asir @carrera-coches.sql 

expdp usuariopruebas/usuariopruebas directory=directorypruebas schemas=usuariopruebas dumpfile=usuariopruebas.dmp logfile=usuariopruebas.log 

# Delete information on tables of SQL 
delete from  resultados;

# Import datafiles 
# For import the data of tables the user on Oracle, in my case, I need to desconnect the user in SQlDeveloper
# and eject the importation of data. 

impdp usuariopruebas/usuariopruebas directory=directory tables=resultados table_exists_action=truncate dumpfile=usuariopruebas.dmp logfile=usuariopruebas.log

echo "End script"