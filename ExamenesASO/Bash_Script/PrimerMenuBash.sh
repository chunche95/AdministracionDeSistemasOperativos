#!/bin/bash

####################################################################################################################################################################################################################################
#                                       Descripción: Estructura básica del programa (esquema).
####################################################################################################################################################################################################################################
# function aaaaaa(){
#  clear
#  echo "Sentencia a ejecutar " $(comando)
#  read -p "Pulse para continuar" p
# }
# while true
# do
# echo -e " 8. Salir. "
# read -p "Seleccione una de las opciones que aparece en pantalla: [_]" opcion
# case $opcion in
# 1) microRam ;;
# ...
# 8) salirMenu ;;
# *) echo "Error en la entrada seleccionada, por favor, vuelva a intentarlo de nuevo. ";;
# esac
# done
####################################################################################################################################################################################################################################
####################################################################################################################################################################################################################################
####################################################################################################################################################################################################################################


####################################################################################################################################################################################################################################
# echo -e " 1. Muestra marca y modelo del microprocesador y tamaño de memoria RAM."
####################################################################################################################################################################################################################################

function microRam(){
  clear
  echo Marca de procesador: $( cat /proc/cpuinfo | grep "model name" | awk '{print $4}')
  echo Modelo del procesador: $( cat /proc/cpuinfo | grep "model name" | awk '{print $5 , $6 }')
  echo Tamaño de la memoria RAM: $( cat /proc/meminfo | grep "MemTotal" | awk '{print $2}')
  read -p "Pulse para continuar" p
}


####################################################################################################################################################################################################################################
# echo -e " 2. Muestra espacio ocupado por todos los directorios de /. "
####################################################################################################################################################################################################################################

function espacio(){
  echo "Primera solución - Es necesario ejecutarla con privilegios elevados."
  sudo du -csh / | sort -nr > /tmp/disco.txt
  clear
  echo "Espacio ocupado por todos los directorios de / : " $(tail -n 1 /tmp/disco.txt)
  sleep 2
  echo "Segunda solución"
  echo "Espacio ocupado por todos los directorios de / : " $(df -h | grep "/dev/sda" | awk '{print $3 , $6}')
  sleep 2
  read -p "Pulse para continuar" p
}

####################################################################################################################################################################################################################################
# echo -e " 3. Subir ligeramente la prioridad a todos los procesos del usuario alumno. "
####################################################################################################################################################################################################################################

function procesosAlumno(){
  echo "No debe olvidarse: Mayor prioridad  -20 (menos veinte) y Menor prioridad +19 (más diecinueve)."
  echo "Prioridad actual del usuario:" $(ps al | grep alumno | awk '{print $6}')
  echo "Subiendo la prioridad del usuario alumno" $(sudo renice +3 -u alumno )
  read -p "Pulse para continuar" p
}

####################################################################################################################################################################################################################################
# echo -e " 4. Comprobar si está instalado el servidor web nginx y si no, instalarlo. "
####################################################################################################################################################################################################################################

function instaladoNginx(){
  echo "Comprobando sí Nginx existe en el sistema.1"
  comprueba =$(dpkg -s nginx | echo $?)
  if [ $comprueba != 0 ]
  then
    echo "El servidor está instalado. Su ruta es:" $(which nginx)
  else
    echo "No está instalado, procedemos a instalar NGINX."
    sudo apt-get install -y nginx
    echo "Instalación del servicio terminada"
    read -p "¿Desea que iniciemos ahora el servicio?" resp
    if [ $resp == 'Y' ] || [ $resp == 'y' ] || [ $resp == 'S' ] || [ $resp == 's' ]
    then
      echo "OK...Estamos en ello jefe"
      /etc/init.d/nginx restart
      echo "Terminamos..."
    else
      echo "OK... Sin problema ;)"
    fi
  fi
  read -p "Pulse para continuar" p
}

####################################################################################################################################################################################################################################
# echo -e " 5. Comprobar si el servidor nginx está arrancado y respondiendo en el puerto 80, sino arrancarlo. "
####################################################################################################################################################################################################################################

function arrancadoNginx(){
  echo "Comprobando el estado del servicio... Por favor, espere."
  servicio=$(systemctl list-unit-files | grep nginx )
  estado=$($servicio | awk '{print $2}' )
  echo "Estado del servicio: " $servicio
  echo "Puerto de escucha del servicio: " $(sudo netstat -puntl | grep 'nginx' | awk '{print $4}' | cut -f2  -d":")
  if [ $estado != 'enabled' ]
  then
    echo "El servicio no está encendido -- Procedemos a intentar arrancarlo."
    sleep 1
    echo -e "\e[1;35 Espere un momento \[0m"
    /etc/init.d/nginx restart
  else
    echo "El servicio está encendido"
  fi
  read -p "Pulse para continuar" p
}

####################################################################################################################################################################################################################################
# echo -e " 6. Programar la reconfiguración  del servidor nginx a 10 procesos worker en la madrugada del domingo al lunes a 26/05/2019 a las 2.30."
####################################################################################################################################################################################################################################

function programaReconfig(){
  read -p "Pulse para continuar" p
}

####################################################################################################################################################################################################################################
# echo -e " 7. Mostrar cada 3 segundos todos los procesos del usuario que corre nginx y los 5 que más memoria
# real consumen del usuario alumno ordenados por uso de memoria real (rss) descendente.
# (mostrar uid,pid,cmd y rss). "
####################################################################################################################################################################################################################################

function procesosMasNginx(){
  procesosNginx=$(ps -aux | grep 'nginx')
  otrosProcesos=$(ps -Ao uid,pid,cmd,rss --sort -rss | head -5 )
  contador=0
  echo "Vera los procesos 10 veces, así no será un bucle infinito. "
  while [ $contador -lt 10 ]
  do
    echo "Procesos solicitados:"
    $procesosNginx
    $otrosProcesos
    sleep 3
    let $contador++
  done
  read -p "Pulse para continuar" p
}

####################################################################################################################################################################################################################################
# echo -e " 8. Salir. "
####################################################################################################################################################################################################################################

function salirMenu(){
  clear
  echo "Saliendo del menú de gestión de servicios."
  sleep 2
  echo -e "\e[34 Fin de programa. \e"
 exit
}

while true
do
echo -e "  "
clear
echo -e "\e[1;31 Menu info web.  \e"
echo -e "\e[2;35 "
echo -e " 1. Muestra marca y modelo del microprocesador y tamaño de memoria RAM."
echo -e " 2. Muestra espacio ocupado por todos los directorios de /. "
echo -e " 3. Subir ligeramente la prioridad a todos los procesos del usuario alumno. "
echo -e " 4. Comprobar si está instalado el servidor web nginx y si no, instalarlo. "
echo -e " 5. Comprobar si el servidor nginx está arrancado y respondiendo en el puerto 80, sino arrancarlo. "
echo -e " 6. Programar la reconfiguración  del servidor nginx a 10 procesos worker en la madrugada del domingo al lunes a 26/05/2019 a las 2.30."
echo -e " 7. Mostrar cada 3 segundos todos los procesos del usuario que corre nginx y los 5 que más memoria real consumen del usuario alumno ordenados por uso de memoria real (rss) descendente (mostrar uid,pid,cmd y rss). "
echo -e " 8. Salir. "
echo -e " \e "

read -p "Seleccione una de las opciones que aparece en pantalla: [" opcion "]"

case $opcion in
1) microRam ;;
2) espacio ;;
3) procesosAlumno ;;
4) instaladoNginx ;;
5) arrancadoNginx ;;
6) programaReconfig ;;
7) procesosMasNginx ;;
8) salirMenu ;;
*) echo "Error en la entrada seleccionada, por favor, vuelva a intentarlo de nuevo. ";;
esac
done
