#!/bin/bash

DIA=$(date +"%d/%m/%Y")
HORA=$(date +"%H:%M")
echo "Nota importante: Para el buen funcionamiento del script, algunas tareas necesitan privilegios avanzados, por ello le recomendamos que ejecute el script con privilegios de root."

function menu1(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
echo "Información de procesador y memoria instalada: "
echo "Procesador: " $(cat /proc/cpuinfo | grep 'model name' | head)
echo "Memoria: " $(cat /proc/meminfo | grep 'MemTotal' | head)
echo "Pulse para continuar"
read  nada
}

function menu2(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
echo "Espacio ocupado por los discos en / "
echo "Espacio en disco usando df (Opcion 1): "
df -h /
echo ""
echo "Espacio en disco usando du (Opcion 2): "
sudo du -h / | sort -rn | head
echo "Pulse para continuar"
read  nada
}

function menu3(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
echo "Subiendo la prioridad de los procesos de 'alumno'"
sudo renice -n -10 -u alumno &
echo "Prioridad subida"
echo "Pulse para continuar"
read  nada
}

function menu4(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
echo "Comprobando si GNINX está instalado. "
which -a nginx
case $? in 
	0) echo "El servidor está instalado!";;
	*) echo "NGINX no está instalado...vamos a instalarlo.";
		apt-get install nginx -y;;
esac
echo "Pulse para continuar"
read  nada
}

function menu5(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
netstat -tlnp | grep nginx &>/dev/null
case $? in
	0) echo "El servidor está activado";;
	*) echo "NGINX no está activo, lo arrancamos";
	   service nginx start;
	   service nginx status;
	   echo "Servidor arrancado!";;
esac
echo "Pulse para continuar"
read  nada
}

function menu6(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
echo  “sed -i 's/worker_processes\ 4/worker_processes\ 10/g' “/etc/nginx/nginx.conf” > /tmp/atjobs.txt
echo "service nginx restart " >> /tmp/atjobs.txt
at -t 12050230 -f /tmp/tmp/atjobs.txt
atq
echo "Pulse para continuar"
read  nada
}

function menu7(){
clear
cuenta=0
while [ $cuenta -le 5 ] 
do
	clear
	echo -e "\e[42m $DIA $HORA \e[0m"
	echo "Procesos nginx"
	echo "--------------"
	ps -U "www-data" -o uid,pid,cmd,rss --sort=-rss
	echo  "Procesos de alumno que mas memoria consumen"
	echo "********************************************"
	ps -U alumno -o uid,pid,cmd,rss --sort=-rss | head -6
	((cuenta++))
	sleep 3
done
echo "Pulse para continuar"
read  nada
}

function menu8(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
clear
	which -a apache2
	case $? in 
		0)
			echo "El servidor apache va a ser reiniciado... Por favor espere";
			/etc/init.d/apache2 restart;
			echo "Servidor Apache reiniciado";;
		*)
			echo "El servidor no se encuentra en el sistema";
			read -p "¿Desea instalarlo?" respuesta
			if [ $respuesta == 's' ] 
			then
				echo "Servidor Apache =====> Instalando! "
				sudo apt-get install apache2 -y
				sleep 2
				echo -e "\e[42m INSTALACIÓN FINALIZADA \e[0m"
			elif [ $respuesta == 'S' ]
			then
				echo "Servidor Apache =====> Instalando! "
				sudo apt-get install apache2 -y
				sleep 2
				echo -e "\e[42m INSTALACIÓN FINALIZADA \e[0m"			
			else
				echo "Vale! "
				echo "Saliendo..."
				sleep 2
				echo ""
			fi
			echo "Volviendo al menú principal";;
		esac

read -p "Pulse para continuar" nada
}

function menu9(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
clear
	echo -e "\e[1;2m Los procesos con más consumo de CPU son: \e[0m"
	ps -o pid,%cpu,%mem,uid,cmd,rss --sort=-%cpu | head -10

read -p "Pulse para continuar" nada

}

function menu10(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
echo -e "\e[1;4m Estos son los usuarios encontrados \e[0m"
	echo -e "\e[44m Opcion 1: \e[0m" 
	w -sh
	echo  -e "\e[44m Opcion 2: \e[0m"
	last -Fn 10
	echo  -e "\e[44m Opcion 3: \e[0m" 
	uptime | cut -d',' -f'2'
read -p "Pulse para continuar" nada

}

function menu11(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
echo "Cargas de trabajo:" 
	$_CMD uptime |awk -F'average:' '{ print $2}'
	echo ""
	echo  -e "\e[0;1m La carga de trabajo del sistema hace un minuto es: \e[0m"
	uptime | awk '{print $(NF-2)}'

read -p "Pulse para continuar" nada

}

function menu12(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
read -p "Introduzca el usuario del sistema: " usuario
	getent passwd $usuario > /dev/null
	if [ $? -eq 0 ];
	then
		echo -e "\e[42m Usuario encontrado \e[0m"
		echo "Vamos a leer su crontab...espere"
		crontab -l -u $usuario 
	else
		echo "\e[5;0m No, el usuario no existe en el sistema \e[0m"
	fi
read -p "Pulse para continuar" nada

}

function menu13(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
echo -e "\e[0;1m Estos son 5 procesos que consumen mucha memoria en el sistema \e[0m"
	echo ">>>Esto es por si le sirve de ayuda a buscar el pid a priorizar<<<"
	ps -aux --sort=-%mem | head -5
	sleep 3
	read -p "Introduzca el PID del proceso que desea: " pid
	echo "Reindicando la prioridad del proceso $pid"
	if ! renice -n -15 $pid > /dev/null 2>&1; then
		echo "No se encuentra en el sistema el PID" $pid
	fi
	echo "Terminado!"

read -p "Pulse para continuar" nada
}

function menu14(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
echo -e "\e[1;3m Información de las particiones de los discos \e[0m"
	df . -h
read -p "Pulse para continuar" nada
}

function menu15(){
clear
echo -e "\e[42m $DIA $HORA \e[0m"
registro=tcpPort.log
resultado=puertosProcesos-TCP.txt
puertos=$(cat /etc/services | grep /tcp | cut -f1 -d "/" | awk '{print $2}')

echo "\e[2;2m Comprobando puertos en `date`" >> $registro
# Desactivamos el firewall para evitar problemas
ufw disable >> $registro
for TCPPORT in `echo $puertos`
do
	pids=`lsof -i \:$TCPPORT | awk '{ print $2 }' | grep -v PID`
	if [ $? -eq "0" ]
	then
		echo "El puerto $TCPPORT esta abierto, estos son sus procesos relacionados: ">> $resultado
		echo "------------------------------------------------------------------------------" >> $resultado
		ps -p $pids >> $resultado
		echo " " >> $resultado
	else
		echo "El puerto $TCPPORT no está a la escucha en el sistema" >> $registro
	fi
done
echo "El resultado del chequeo esta en $resultado , su contenido es ; "
echo "================================================================"
cat $resultado
echo "Fin de ejecucion" >> $registro
echo "....................." >> $registro
read -p "Pulse para continuar" nada
}

function menu16(){
    clear
	
    read -p "Introduzca una de las opciones '-u'--> Usuario '-a'-->Grupo: " letra
    read -p "Introduzca el nombre del usuario o grupo a detallar: " nombre
# Comprobación de la existencia de los dos parametros de entrada.
#if [ $# -ne 2 ]
#then 
#    echo -e "\e[41m El script no recibio los 2 parámetros esperados. \e[0m"
#    sleep 2
#    clear
#    exit
#elif [ $# -lt 2 ]
#then 
#    echo -e "\e[41m Se recibieron menos de  dos parámetros. \e[0m"
#    sleep 2 
#    clear
#    exit
#elif [ $# -gt 0 ] && [ -z $1 ]
#then 
#    echo -e "\e[41m El script recibió parámetros, pero el primero está en blanco \e[0m"
#    sleep 2
#    clear
#    exit
#fi

# Comprobacion de la entrada de parámetros
 
if [ "$letra" != "-u" ] && [ "$letra" != "-a" ]
then
    echo -e "\e[0;31m Hay un error en el orden de los parámetros introducidos ... Por favor, vuelva a intentarlo \e[0m"
elif [ "$letra" == "-u" ]
then 
    echo -e "\e[1;3m Leyendo primer parámetro....Por favor, espere \e[0m" 
    sleep 2
    if  id -u "$nombre" >/dev/null 2>&1;
    then 
        echo -e "\e[1;3m Leyendo segundo parámetro....Por favor, espere \e[0m"
        sleep 2
            echo -e "\e[42m Usuario encontrado...\e[0m"
            sleep 1
                echo -e "\e[44m  Esta es la información encontrada del usuario $nombre \e[0m"
                    echo -e "\e[0;2m Nombre: \e[0m"
                        cat /etc/passwd | cut -d":" -f1 | grep $nombre 
                        read -p "Pulse para continuar" nada
                    echo -e "\e[0;2m Número de procesos lanzados:  \e[0m"
                        ps -u  $nombre  --width 30 --sort %cpu | wc -l 
                        read -p "Pulse para continuar" nada
                    echo -e "\e[0;2m Primer proceso lanzado: \e[0m"
                        ps -U $nombre --width 30 --sort etime | head -2 
                        read -p "Pulse para continuar" nada
                    echo -e "\e[0;2m Procesos lanzados: \e[0m"
                        ps -u $nombre -o pid,%mem,%cpu,vsz,rss,tty,stat,comm,etime | head -10
                        ps -u $nombre -o pid,%mem,%cpu,vsz,rss,tty,stat,comm,etime >> /tmp/procesos.txt
                        echo "Tiene un fichero con la información completa en /tmp/procesos.txt"
                        read -p "Pulse para continuar" nada
                    echo -e "\e[0;2m Numero de directorios que tiene: \e[0m"
                        cd /home/$nombre 
                        pwd
                        ls -l | grep ^d | wc -l
                        read -p "Pulse para continuar" nada
                    echo -e "\e[0;2m Numero de ficheros que tiene: \e[0m"
                        cd /home/$nombre 
                        pwd
                        ls -l | grep -v ^d | wc -l
                        read -p "Pulse para continuar" nada
                    echo -e "\e[0;2m Uso del disco: \e[0m"
                        sudo du -sh /home/$nombre 
                        read -p "Pulse para continuar" nada 
    fi
elif [ "$letra" == "-a" ]    
then
    echo -e "\e[33m Supongo que buscas entonces un grupo...Procedo a buscarlo, espere \e[0m"
    cat /etc/group | grep $nombre
    members $nombre
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

}

function menuSalir(){
	clear
	echo -e "\e[4;2m --------------------------------------------	\e[0m"
	echo -e "\e[3;3m |           $DIA $HORA 		    |	\e[0m"
	echo -e "\e[2;2m |Saliendo del programa...Por favor, espere |	\e[0m"
	sleep 2	
	echo -e "\e[2;2m |  Fin del programa, programa finalizado.  |	\e[0m"
	echo -e "\e[5;2m |    Gracias por usar a pauchino.    :D    |	\e[0m"
	echo -e "\e[4;2m --------------------------------------------	\e[0m"
	sleep 2
	clear
	exit
}

while true
do
clear
echo -e "\e[0;36m -----------------------  BIENVENIDO A TU SCRIPT DE AYUDA  -----------------------	\e[0m"
echo -e "\e[0;34m ================================================================================= 	\e[0m"
echo -e "\e[0;34m 1) Muestra marca y modelo del microprocesador y tamaño de memoria RAṂ̣		    	\e[0m"
echo -e "\e[0;34m 2) Muestra  ocupación de todos los directorios de /					\e[0m"
echo -e "\e[0;34m 3) Subir ligeramente la prioridad a todos los procesos del usuario alumno		\e[0m"
echo -e "\e[0;34m 4) Comprobar si está instalado el servidor web nginx y si no instalarlo		\e[0m"
echo -e "\e[0;34m 5) Comprobar si el servidor web nginx está arrancando y respondiendo			\e[0m"
echo -e "\e[0;34m 6) Programar la reconfiguración del servidor nginx en la madrugada del domingo	\e[0m" 
echo -e "\e[0;34m al lunes										\e[0m"
echo -e "\e[0;34m 7) Mostrar cada 3 segundos todos los procesos del usuario que corre nginx y los 5	\e[0m" 
echo -e "\e[0;34m que más memoria real consumen del usuario alumno,ordenados por memoria real(rss)	\e[0m"
echo -e "\e[0;34m descendente (mostrar uid,pid,cmd y rss)						\e[0m"
echo -e "\e[0;34m 8) Reiniciar el servidor Apache.							\e[0m"
echo -e "\e[0;34m 9) Mostrar los procesos que más CPU consumen						\e[0m"
echo -e "\e[0;34m 10) Mostrar los usuarios conectados al sistema					\e[0m"
echo -e "\e[0;34m 11) Mostrar la carga del sistema hace 1 minuto					\e[0m"
echo -e "\e[0;34m 12) Mostrar el contenido del cron del usuario introducido 				\e[0m"
echo -e "\e[0;34m 13) Bajar la prioridad a 15 del proceso introducido 					\e[0m"
echo -e "\e[0;34m 14) Ver información de las particiones de los discos					\e[0m"
echo -e "\e[0;34m 15) Ver puertos TCP abiertos en el sistema, con informe general en fichero.											\e[0m"
echo -e "\e[0;34m 16) Ver información detallada de usuario o grupo introduciendo los parámetros por pantalla											\e[0m"
echo -e "\e[0;34m XX)											\e[0m"

echo -e "\e[1;36m s) Salir										\e[0m"
echo -e "\e[0;34m ================================================================================= \e[0m"
read -p "Introduce una opción: " opcion
case $opcion in
	1) menu1;;
	2) menu2;;
	3) menu3;;	
	4) menu4;;
	5) menu5;;
	6) menu6;;
	7) menu7;;
	8) menu8;;
	9) menu9;;
	10) menu10;;
	11) menu11;;
	12) menu12;;
	13) menu13;;
	14) menu14;;

	15) menu15;;
	16) menu16;;

	s) menuSalir;;
	S) menuSalir;;
esac
done
