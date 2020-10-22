#!/bin/bash 
#pedir nombre fichero
read -p "Introduce el nombre de un fichero: " fichero
fichFind=`find /home/mgf -iname $fichero 2>/dev/null`
if [ -f $fichFind -a -s $fichFind ]; then
echo "El fichero $fichero, tiene el siguiente contenido: "
cat $fichFind
else 
echo El fichero $fichero o no existe o esta vacío
fi

