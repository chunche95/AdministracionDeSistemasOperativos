#!/bin/bash

function menu1(){
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

read -p "Pulse para continuar" inicio
}

function menu2(){
	clear
	echo -e "\e[1;2m Los procesos con más consumo de CPU son: \e[0m"
	ps -o pid,%cpu,%mem,uid,cmd,rss --sort=-%cpu | head -10

read -p "Pulse para continuar" inicio	
}

function menu3(){
	clear
	echo -e "\e[1;4m Estos son los usuarios encontrados \e[0m"
	echo "Opcion 1: " 
	w -sh
	echo "Opcion 2:  " 
	#last -Fn 10
	echo "Opcion 3:  " 
	#uptime | cut -d',' -f'2'

	read -p "Pulse para continuar" inicio
}

function menu4(){
	clear
	echo "Cargas de trabajo:" 
	$_CMD uptime |awk -F'average:' '{ print $2}'
	echo ""
	echo  -e "\e[0;1m La carga de trabajo del sistema hace un minuto es: \e[0m"
	uptime | awk '{print $(NF-2)}'

	read -p "Pulse para continuar" inicio
}

function menu5(){
	clear
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

	read -p "Pulse para continuar" inicio
}

function menu6(){
	clear
	echo -e "\e[0;1m Estos son 5 procesos que consumen mucha memoria en el sistema \e[0m"
	echo ">>>Esto es por si le sirve de ayuda a buscar el pid a priorizar<<<"
	ps -aux --sort=-%mem | head -5
	sleep 3
	read -p "Introduzca el PID del proceso que desea: " pid
	echo "Reindicando la prioridad del proceso $pid"
	if ! renice -n -15 $pid > /dev/null 2>&1; then
		echo "No se encuentra en el sistema el PID" $pid
	fi
	echo "Hecho!"

	read -p "Pulse para continuar" inicio
}

function menu7(){
	clear
	echo -e "\e[1;3m Información de las particiones de los discos \e[0m"
	df . -h

	read -p "Pulse para continuar" inicio
}

function menu8(){
	clear
	echo -e "\e[1;3m Gracias por usar el programa: \e[0m"
	echo -e "\e[0;2m        MenuPaulino.sh         \e[0m"
	echo    "         Saliendo del programa...	    "
	sleep 2
	echo    "====>        Programa finalizado  	    "

	read -p "Pulse para continuar" inicio
	exit
}

while true
do
clear
echo -e "\e[0;36m -----------------------  BIENVENIDO A TU SCRIPT DE AYUDA  -----------------------	\e[0m"
echo -e "\e[0;34m ================================================================================= 	\e[0m"
echo -e "\e[0;34m 1.Reiniciar servidor web apache							\e[0m"
echo -e "\e[0;34m 2.Mostrar proceso que más cpu está consumiendo					\e[0m"
echo -e "\e[0;34m 3.Mostrar usuarios conectados al sistema						\e[0m"
echo -e "\e[0;34m 4.Mostrar la carga del sistema hace 1 minuto						\e[0m"
echo -e "\e[0;34m 5.Mostrar el contenido del cron del usuario que se solicita por pantalla		\e[0m"
echo -e "\e[0;34m 6.Bajar la prioridad a 15 del proceso cuyo pid se solicita al usuario			\e[0m"
echo -e "\e[0;34m 7.Ver información de las particiones de los discos					\e[0m"
echo -e "\e[0;34m 8.Salir										\e[0m"

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
esac
done


