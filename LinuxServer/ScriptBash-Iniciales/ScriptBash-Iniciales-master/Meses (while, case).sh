#!/bin/bash

cont=0

while [ $cont -eq 0 ]
do

    echo 'Introduca el mes (0 para salir)'
    read mes

    case $mes in
        0)
            echo 'Hasta luego Lucas'
            cont=1
            ;;
        1)
            echo 'El mes '$mes' es Enero'
            ;;
        2)
            echo 'El mes '$mes' es Febrero'
            ;;
        3)
            echo 'El mes '$mes' es Marzo'
            ;;
        4)
            echo 'El mes '$mes' es Abril'
            ;;
        5)
            echo 'El mes '$mes' es Mayo'
            ;;
        6)
            echo 'El mes '$mes' es Junio'
            ;;
        7)
            echo 'El mes '$mes' es Julio'
            ;;
        8)
            echo 'El mes '$mes' es Agosto'
            ;;
        9)
            echo 'El mes '$mes' es Septiembre'
            ;;
        10)
            echo 'El mes '$mes' es Octubre'
            ;;
        11)
            echo 'El mes '$mes' es Noviembre'
            ;;
        12)
            echo 'El mes '$mes' es Diciembre'
            ;;
        *)
            echo $mes' no es un mes válido'
            ;;
    esac
    echo ''
done