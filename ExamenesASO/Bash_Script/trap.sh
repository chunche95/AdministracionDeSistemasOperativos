#!/bin/bash
PID=`pgrep trap.sh`
USUARIO=`whoami`
echo "Tengo el PID "$PID""
echo Pulsa una tecla
read nada
while true
do
  trap '/usr/sbin/ntpdate -u hora.roa.es' SIGHUP
  sleep 2
done
