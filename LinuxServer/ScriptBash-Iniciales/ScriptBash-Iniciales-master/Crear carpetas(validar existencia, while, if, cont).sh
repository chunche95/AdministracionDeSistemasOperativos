#!/bin/bash

read -p 'Cuantas carpetas quieres crear? ' cant

cont=1

while [ $cont -le $cant ]
do
    
    read -p "Introduzca el nombre de la carpeta número: $cont - " carpeta

    if [ -d $carpeta ]; then
        echo 'La carpeta ya existe'
    else
        mkdir $carpeta
        echo 'Carpeta creada'
    fi

    cont=`expr $cont + 1`

done