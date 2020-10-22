#!/bin/bash

#Elabora un script para llamado informe.sh que muestre 
#información sobre el uso del sistema que realiza un determinado usuario. 
#El shell-script tendra la siguiente sintaxis:
#informe.sh opcion [usuario]

#Las opciones pueden ser –u y –a.

# + Si la opción que recibe es –u,.
# |
# |-> Deberá recibir como segundo argumento un nombre de usuario.

# + Si el script se ejecuta de la primera forma (-u usuario).
# |
# |-- Deberá presentar un informe del usuario que se ha pasado por parámetro.
# |     + En el informe deberán aparecer los siguientes datos:
# |     |>· Nombre del usuario.
# |     |>· Número de procesos que ha lanzado.
# |     |>· Nombre del primer proceso que lanzó.
# |     |>· Listado de todos los procesos que ha lanzado.
# |     |>· Número de directorios que tiene.
# |     |>· Número de ficheros regulares que tiene.
# |     |>· Uso del espacio en disco que ocupa.
# |     |>· Tanto por ciento de espacio en disco usado por el usuario.
# |
# + Fin del Script

clear
# Comprobación de la existencia de los dos parametros de entrada.
if [ $# -ne 2 ]
then 
    echo -e "\e[41m El script no recibio los 2 parámetros esperados. \e[0m"
    sleep 2
    clear
    exit
elif [ $# -lt 2 ]
then 
    echo -e "\e[41m Se recibieron menos de  dos parámetros. \e[0m"
    sleep 2 
    clear
    exit
elif [ $# -gt 0 ] && [ -z $1 ]
then 
    echo -e "\e[41m El script recibió parámetros, pero el primero está en blanco \e[0m"
    sleep 2
    clear
    exit
fi

# Comprobacion de la entrada de parámetros
 
if [ "$1" != "-u" ] && [ "$1" != "-a" ]
then
    echo -e "\e[0;31m Hay un error en el orden de los parámetros introducidos ... Por favor, vuelva a intentarlo \e[0m"
elif [ "$1" == "-u" ]
then 
    echo -e "\e[1;3m Leyendo primer parámetro....Por favor, espere \e[0m" 
    sleep 2
    if  id -u "$2" >/dev/null 2>&1;
    then 
        echo -e "\e[1;3m Leyendo segundo parámetro....Por favor, espere \e[0m"
        sleep 2
            echo -e "\e[42m Usuario encontrado...\e[0m"
            sleep 1
                echo -e "\e[44m  Esta es la información encontrada del usuario $2 \e[0m"
                    echo -e "\e[0;2m Nombre: \e[0m"
                        cat /etc/passwd | cut -d":" -f1 | grep $2 
                        read -p "Pulse para continuar" nada
                    echo -e "\e[0;2m Número de procesos lanzados:  \e[0m"
                        ps -u  $2  --width 30 --sort %cpu | wc -l 
                        read -p "Pulse para continuar" nada
                    echo -e "\e[0;2m Primer proceso lanzado: \e[0m"
                        ps -U $2 --width 30 --sort etime | head -2 
                        read -p "Pulse para continuar" nada
                    echo -e "\e[0;2m Procesos lanzados: \e[0m"
                        ps -u $2 -o pid,%mem,%cpu,vsz,rss,tty,stat,comm,etime | head -10
                        ps -u $2 -o pid,%mem,%cpu,vsz,rss,tty,stat,comm,etime >> /tmp/procesos.txt
                        echo "Tiene un fichero con la información completa en /tmp/procesos.txt"
                        read -p "Pulse para continuar" nada
                    echo -e "\e[0;2m Numero de directorios que tiene: \e[0m"
                        cd /home/$2 
                        pwd
                        ls -l | grep ^d | wc -l
                        read -p "Pulse para continuar" nada
                    echo -e "\e[0;2m Numero de ficheros que tiene: \e[0m"
                        cd /home/$2 
                        pwd
                        ls -l | grep -v ^d | wc -l
                        read -p "Pulse para continuar" nada
                    echo -e "\e[0;2m Uso del disco: \e[0m"
                        sudo du -sh /home/$2 
                        read -p "Pulse para continuar" nada 
    fi
elif [ "$1" == "-a" ]    
then
    echo -e "\e[33m Supongo que buscas entonces un grupo...Procedo a buscarlo, espere \e[0m"
    cat /etc/group | grep $2
    members $2
else
    echo "Se ha producido un error inesperado...Vuelva a lanzar el script."
    echo "Causas comunes:"
    echo "- Falta de parámetros."
    echo "- Parámetros de entrada incorrectos."
    echo "- Error de ejecución. XD"
fi

echo "Fin del programa..."
sleep 3
read -p "Programa finalizado. Pulse Enter para salir" nada
