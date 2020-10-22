#!/bin/sh
sh variables.sh

IFS=$'\n'

for var in `df -k | tail -n +2`
do
    hora=`date +"%T"`
    sistema=`echo $var | awk '{print $1}'`
    tamano=`echo $var | awk '{print $2}'`
    usado=`echo $var | awk '{print $3}'`
    montado=`echo $var | awk '{print $6}'`

    sqlplus -s  / as sysdba <<EOF>> /dev/null
    insert into df (hora,sistema,tamano,usado,montado) values ('$hora','$sistema', '$tamano', 'usado', 'montado');
    commit;
    EOF
done
echo $hora "datos guardados en tabla DF" >> /home/alumno/logs/datosTabla.log

IFS=$old_IFS