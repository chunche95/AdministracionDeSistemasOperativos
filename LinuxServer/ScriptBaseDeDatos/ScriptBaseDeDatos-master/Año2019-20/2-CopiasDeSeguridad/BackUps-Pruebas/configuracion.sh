#!/bin/bash


# Crear la carpeta de los BU's.
mkdir /home/alumno/Documents/ScriptBaseDeDatos/Backups

# Cambiamos permisos de lectura y escritura al usuario de sistema que ejecuta Oracle, en este caso es usuario=oracle.
sudo chown oracle .

# Creamos con sys el directory de exportacion en Oracle
sqlplus / as sysdba<<EOF
create directory misbackups as '/home/alumno/Documents/ScriptBaseDeDatos/BackUps';

drop user alumno cascade;
create user alumno identified by alumno default tablespace users quota unlimited on users account unlock;
grant connect, resource to alumno;
grant create any table to alumno;
grant read,write on  directory to alumno;
EOF

# Vemos los procesos de pmon para ver si Oracle funciona

ps -ef | grep -i pmon 


# Realizo la exportacion con alumno

# Exportacion del esquema completa
expdp alumno/alumno schemas=alumno directory=misbackups
echo "BackUp terminado"
sleep 5
clear 
# Exportación de una tabla de un usuario concreto
expdp alumno/alumno dumpfile=mitabla1.dmp directory=misbackups tables=alumno.mitabla1 
echo "BackUp terminado"
sleep 5
clear 

# Importar
impdp alumno/alumno directory=misbackups