#!/bin/bash

echo 'Introduce la carpeta'
read carp

if [ ! -d $carp ]; then
    mkdir $carp
    echo 'La carpeta no existe, se crea automáticamente'
fi

cont=0
contador=0

while [ $cont -eq 0 ]
do
    echo 'Quieres crear un archivo? (si/no)'
    read conte

    if [ $conte = si ]; then
        echo 'Introduce el nombre del nuevo fichero'
        read fich
        touch $carp/$fich
        contador=`expr $contador + 1`
    else
        if [ $conte = no ]; then
            echo 'Hasta luego'
            cont=1
        else
            echo '(si/no)'
        fi
    fi
done

echo 'Se han creado '$contador' archivos'