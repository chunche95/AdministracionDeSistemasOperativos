#!/bin/bash
clear

# Preparing the spaces for the local user (usuariopruebas)
# - Creating the folderes for backups
mkdir '/home/alumno/Documents/ScriptsBaseDeDatos/Backups/usuariopruebas/pruebas/tablespace'
mkdir '/home/alumno/Documents/ScriptsBaseDeDatos/Backups/usuariopruebas/pruebas/backups'

# - Create tablespace of default for the user USUARIOPRUEBAS
# - Create user USUARIOPRUEBAS
# - Asigned the privileges for the user created 
# - Asigned privileges at import and export database
# - Create directory of backups
sqlplus / as sysdba<<EOF
drop user usuariopruebas cascade;

create tablespace tablespacepruebas
datafile '/home/alumno/Documents/ScriptsBaseDeDatos/Backups/Omen/pruebas/tablespace/tablespacepruebas.dbf'
size 50M;

create user usuariopruebas identified by usuariopruebas
default tablespace tablespacepruebas
quota unlimited on tablespacepruebas;

grant connect, resource to usuariopruebas;
grant read any directory to usuariopruebas;
grant create any directory to usuariopruebas;

create directory directorypruebas as '/home/alumno/Documents/ScriptsBaseDeDatos/Backups/Omen/pruebas/backups';

grant read, write on directory directorypruebas to usuariopruebas;

grant exp_full_database to usuariopruebas;
grant imp_full_database to usuariopruebas;
EOF

# Preparing spaces for the user remote (OMEN)
# - Creating the folderes for backups
mkdir '/home/alumno/Documents/ScriptsBaseDeDatos/Backups/Omen/pruebas/tablespace'
mkdir '/home/alumno/Documents/ScriptsBaseDeDatos/Backups/Omen/pruebas/backups'

# - Creating the tablespace on default and asigned at new user (OMEN) this tablespace
# - Create the user - OMEN
# - Granted privileges on the Omen user
# - Create directory of backup

sqlplus / as sysdba<<EOF
drop user omen cascade;

create tablespace tablespaceomen
datafile '/home/alumno/Documents/ScriptsBaseDeDatos/Backups/Omen/pruebas/tablespace/omen.dbf'
size 50M;

create user omen idenfied by omen
default tablespace tablespaceomen
quota unlimited on tablespaceomen;

grant connect, resource to omen;
grant create any directory to omen;

create directory directoryomen as '/home/alumno/Documents/ScriptsBaseDeDatos/Backups/Omen/pruebas/backups';
grant read, write on directory directoryomen to omen;

grant exp_full_database to omen;
grant imp_full_database to omen;
EOF


#####################################################
#                                                   #
#   TEST AUTOEVALUATION MACHINES - EXPDP AND IMPDP  #
#                                                   #
#####################################################

# Charging the test data with the user USUARIOPRUEBAS
sqlplus usuariopruebas/usuariopruebas@10.1.35.51/asir @carreras-coches.sql 

# I have the test exportation, I'm using usuariopruebas in local machine and OMEN in remote machine for this test, the first step is:
# - Create the files DBF and LOG in the remote workspace.
# - Create the files DBF and LOG int the local machine.
# 
# I have the test importation, I'm using the OMEN user for this test. Steps:
# - Impdp in the OMEN user, using the local IP address for this importation. Remaping the schema on the user usuariopruebas

#############################################
# Exportación local de los datos de la BD.  #
# Importación local de los datos de la BD.  #
#############################################
expdp usuariopruebas/usuariopruebas@10.1.35.51/asir directory=directorypruebas dumpfile=usuariopruebas.dmp logfile=usuariopruebas.log
impdp usuariopruebas/usuariopruebas@10.1.35.51/asir schemas=usuariopruebas  dumpfile=usuariopruebas.dmp logfile=usuariopruebas.log 

##############################################
# Exportación remota de los datos de la BD.  #
##############################################
expdp omen/omen directory=directoryomen schemas=omen dumpfile=omen.dmp logfile=omen.log
scp /home/alumno/Documents/ScriptsBaseDeDatos/Backups/Omen/pruebas/backups/omen.* alumno@10.1.35.51:/home/alumno/Documents/ScriptsBaseDeDatos/Backups/usuariopruebas/pruebas/backups

##############################################
# Importacion remota de los datos de la BD.  #
# con remapeado a otro usuario               #
##############################################

impdp usuariopruebas/usuariopruebas schemas=omen remap_schema=omen:usuariopruebas
remap_tablespace=tablespaceomen:tablespacepruebas directory=directorypruebas dumpfile=omen.dmp logfile=omen.log 

