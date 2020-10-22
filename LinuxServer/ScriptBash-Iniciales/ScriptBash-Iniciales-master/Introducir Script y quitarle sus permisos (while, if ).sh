#!/bin/bash

cont=0

while [ $cont -eq 0 ]
do
    read -p 'Introduzca el script ' scr
    
    if [ -x $scr ]; then
        chmod a-x $scr
        echo 'Ya no es un script'
        cont=1
    else
        echo 'No es un script, vuelve a probar'
    fi
    
done