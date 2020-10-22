#!/bin/bash

if [ $# -ne 1 ]; then
    echo 'Debes introducir un parámetro'
else

    fich=$1
    
    while [ ! -f $fich ]
    do
        read -p 'Debes introducir un fichero' fich
    done

    if [ -s $fich ]; then
        echo 'Este fichero ya tenía contenido pero yo le añado más' >> $fich
    else
        echo 'Ya no es un fichero vacío' > $fich
    fi

    echo 'Linea agregada'
fi