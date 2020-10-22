#!/bin/bash 
#un script que pida tu nombre, edad y ciudad donde vives
#pedir nombre carpeta
read -p "Introduce el nombre de la carpeta: " carpeta
if [ -d $carpeta ]; then
echo "La carpeta $carpeta, tiene el siguiente contenido: "
ls -l $carpeta
else 
echo "Introduce un directorio correcto"
fi
