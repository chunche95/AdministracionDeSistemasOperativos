#!/bin/sh

# Accedemos al directorio donde crear el directorio
cd /home/alumno
# Creamos el directorio del tablespace
mkdir tablespace

# Creamos el tablespace en sqlplus
sqlplus / as sysdba<<EOF
create tablespace MITABLESPACE
datafile '/home/alumno/tablespace/MIFICHERO.dbf'
size 800k
autoextend on
<<<<<<< HEAD
next 100k
maxsize 1000k;
grant connect to pau;
grant select to pau;
grant update to pau;
grant delete to pau;
=======
next 200k
maxsize 1400k;
>>>>>>> f5b6b0adb5e3ca68d6dcef917022d36c8ebeec43
exit
EOF

