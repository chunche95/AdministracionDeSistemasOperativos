#!/bin/bash
FECHAHORA=`date +%D" "%T`
DIRHOST='10.1.0.153'
USUARIO='ftpuser'
PASSWORD='ftpuser'
FICHERO='muestra.img'
FICHLOG='/tmp/traefichero.log'
RECODIR='/tmp'
#
# Conexion wget con un timeout de 30 segundos
#
wget --connect-timeout=30 --directory-prefix=$RECODIR --ftp-user=$USUARIO --ftp-password=$PASSWORD ftp://$DIRHOST/$FICHERO &>/dev/null
case $? in
0) echo $FECHAHORA Fichero recogido OK >>$FICHLOG;;
1) echo $FECHAHORA Error generico >>$FICHLOG;;
2) echo $FECHAHORA Error parseo .wgetrc o .netrc >>$FICHLOG;;
3) echo $FECHAHORA Error de entrada\/salida >>$FICHLOG;;
4) echo $FECHAHORA Fallo de red >>$FICHLOG;;
5) echo $FECHAHORA Error de verificacion SSL >>$FICHLOG;;
6) echo $FECHAHORA Fallo de autenticacion usuario\/password >>$FICHLOG;;
7) echo $FECHAHORA Error de protocolo >>$FICHLOG;;
8) echo $FECHAHORA Respuesta fallida del servidor >>$FICHLOG;;
*) echo $FECHAHORA Error generico >>$FICHLOG;;
esac
