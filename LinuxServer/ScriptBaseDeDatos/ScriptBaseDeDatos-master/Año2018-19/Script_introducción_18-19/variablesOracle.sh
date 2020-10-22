#!/bin/sh

#######################################################################
# Añadiendo las variables de Oracle al Path de la terminal de Centos. #
#######################################################################

# Accedo al home del usuario
cd /home/alumno
# Carpeta donde instalamos el ORACLE
export ORACLE_HOME=/home/alumno/oracle-install-18c 
# Añado las variables al Path de Centos
export PATH=$PATH:$ORACLE_HOME/bin 