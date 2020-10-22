#!/bin/bash

if [ $# -eq 1 ] && [ -d $1 ]; then
    cont=0
    while [ $cont -eq 0 ]
    do
        clear
        echo ''
        echo 'Que quieres hacer con el directorio???'
        echo ''
        echo 'a. Mostrar contenido'
        echo 'b. Cuantos elementos contiene la carpeta'
        echo 'c. Ampliar permisos carpeta'
        echo 'd. Salir'
        echo ''
        read ans
        case $ans in
            a)
                echo 'Mostrando contenido'
                ls -l $1
                ;;
            b)
                contar=`ls -l $1 | wc -l`
                total=`expr $contar - 1`
                echo 'La carpeta contiene: '$total' elementos'
                ;;
            c)
                echo 'Amppliando permisos'
                chmod 777 $1
                ;;
            d)
                echo 'Hasta luego'
                cont=1
                ;;
            *)
                echo 'opción incorrecta'
                ;;
        esac

        echo ''
        read -n1 -s -p 'Pulsa una tecla para continuar' enter

    done
else
    echo 'Debes introducir un solo parámetro y debe ser una carpeta'
fi