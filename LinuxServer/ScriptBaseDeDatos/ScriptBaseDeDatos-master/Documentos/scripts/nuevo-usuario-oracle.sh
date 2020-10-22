#!/usr/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c
ORACLE_SID=asir
PATH=$PATH:/home/alumno/oracle-install-18c/bin
export ORACLE_HOME
export ORACLE_SID

usr=$1
pwd=$2

usuarios(){
        ORACLE_SID=asir sqlplus / as sysdba <<EOF>>/dev/null
        create user $usr identified by $pwd;
        grant connect, resource to $usr;
EOF
return $?
}
resultado=$?
if [ $# -eq 2 ]; then {
        usuarios
        if [ $resultado -eq 0 ];then {
        ORACLE_SID=asir sqlplus / as sysdba <<EOF
        alter user $usr account unlock;
        alter user $usr identified by $pwd;
EOF
}
fi
}
else {
      echo "Un usuario nuevo en la BD con permisos connect y resource.
Si ya existe lo desbloquea y le cambia la password.
Sintaxis: nuevo-usuario-oracle.sh <usuario> <password>"
      }
fi