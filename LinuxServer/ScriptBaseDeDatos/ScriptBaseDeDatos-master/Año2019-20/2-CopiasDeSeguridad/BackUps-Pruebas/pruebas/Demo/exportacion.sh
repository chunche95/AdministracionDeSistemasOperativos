#!/bin/bash
clear
# Creacion de carpeta de backups
# Carpeta con datos
mkdir Omen
# Carpeta donde se exporta
mkdir Pauchino
echo "TABLESPACE."
echo "Tablespace de pauchino --> exportacion"
echo "Tablespace de omen --> exportacion"
echo ""
echo "USUARIOS."
echo "Usuario primero con los datos a exportar -- Omen"
echo "Usuario segundo con los datos a importar -- Pauchino"
echo ""
# Exportaciones
sqlplus / as sysdba<<EOF

host echo " ==========================> Creación de tablespace EXPORTACIÓN ==> ruta: ~/pruebas/Pauchino/"
host echo " =================================================================> ruta: ~/pruebas/Omen/"
host echo ""
host echo ""
drop tablespace exportacionOmen;
create tablespace exportacionOmen
datafile '/home/alumno/Documents/ScriptBaseDeDatos/BackUps/pruebas/Omen/omen.dbf'
size 50M;
drop tablespace exportacionPau;
create tablespace exportacionPau
datafile '/home/alumno/Documents/ScriptBaseDeDatos/BackUps/pruebas/Pauchino/pau.dbf'
size 50M;

host echo " ==========================> Usuario pruebas -- Omen."
drop user omen cascade;
create user omen identified by omen
default tablespace exportacionPau
quota unlimited on exportacionPau;
host echo " ==========================> Usuario pruebas -- Pauchino."
drop user pauchino cascade;
create user pauchino identified by pauchino 
default tablespace exportacion 
quota unlimited on exportacion;

host echo " ==========================> Permisos de connect y resource para los usuarios."
grant connect, resource to pauchino;
grant create any directory to pauchino;
grant connect, resource to omen;
grant create any directory to omen;

host echo " ==========================> Creando directorio de EXPORTACIONES para PAUCHINO"
create directory EXPORTACIONES as '/home/alumno/Documents/ScriptBaseDeDatos/BackUps/pruebas/Pauchino';

grant read,write on directory EXPORTACIONES to omen;
grant exp_full_database to omen;
grant read,write on directory EXPORTACIONES to pauchino;
grant exp_full_database to pauchino;
EOF


# Cargo datos
sqlplus pruebas/pruebas@10.1.35.51/asir @carreras-coches.sql
echo "Tablas cargadas"
# Realizando exportacion 
expdp pruebas/pruebas@10.1.35.51/asir directory=EXPORTACIONES schemas=pruebas dumpfile=EXPORTACION_DE_OMEN.dmp logfile=EXPORTACION_DE_OMEN.log
echo "Fin de exportacion"
# Copiar el fichero exportado a otro usuario o equipo
scp /home/alumno/Documents/ScriptBaseDeDatos/BackUps/pruebas/Pauchino/EXPORTACION_DE_OMEN.* pruebas2@10.1.35.51/asir:/home/alumno/Documents/ScriptBaseDeDatos/BackUps/pruebas/Omen
echo "Archivo copiado"



echo "Fin del SCRIPT"


