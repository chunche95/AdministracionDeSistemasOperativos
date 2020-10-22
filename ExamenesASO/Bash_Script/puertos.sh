#! /bin/bash
# Script que mira, de todos los puertos tcp en el fichero services, cuales estan escuchando y por que proceso
#

REGISTRO=/tmp/tcpports.log
RESULTADO=/tmp/puertos-procesos-tcp.txt
PUERTOS=`cat /etc/services | grep /tcp | cut -f1 -d "/" | awk '{print $2}'`

echo Comprobando puertos en `date` >> $REGISTRO
# Desactivamos firewall para evitar interferencia
ufw disable >> $REGISTRO
for TCPPORT in `echo $PUERTOS`
do
PIDS=`lsof -i \:$TCPPORT|awk '{ print $2 }' |grep -v PID`
if [ $? -eq "0" ]
then
echo El puerto $TCPPORT esta abierto, estos son sus procesos relacionados >> $RESULTADO
echo --------------------------------------------------------------------- >> $RESULTADO
ps -p $PIDS >> $RESULTADO
echo " " >> $RESULTADO
else 
echo "El puerto $TCPPORT no esta a la escucha en el sistema" >> $REGISTRO
fi
done
echo El resultado del chequeo esta en $RESULTADO , te muestro el contenido
echo =========================================================================================
cat $RESULTADO
echo Fin de ejecucion >> $REGISTRO
echo ----------------- >> $REGISTRO
