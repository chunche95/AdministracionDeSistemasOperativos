#!/usr/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c
ORACLE_SID=asir
PATH=$PATH:/home/alumno/oracle-install-18c/bin
export ORACLE_HOME
export ORACLE_SID

# Cambiamos el tipo de separador de campo interno
IFS=$'\n'

# Con el for metemos todos los datos en variables 
for dato in `df -k | tail -n +2`
do 
    hora=`date +"%T"`
	sistema=`echo $dato | awk '{print $1}'`
    tamano=`echo $dato | awk '{print $2}'`
    usado=`echo $dato | awk '{print $3}'`
    montado=`echo $dato | awk '{print $6}'`

# Los metemos en la tabla df con un heredoc
    sqlplus -s / as sysdba <<EOF >> /dev/null
    insert into df (hora,sistema,tamano,usado,montado) values ('$hora','$sistema','$tamano','$usado','$montado');
    commit;
EOF
done

echo $hora "datos insertados en tabla" >> /home/alumno/scripts/log.log

# Devolvemos el separador de campo interno a su valor
IFS=$old_IFS