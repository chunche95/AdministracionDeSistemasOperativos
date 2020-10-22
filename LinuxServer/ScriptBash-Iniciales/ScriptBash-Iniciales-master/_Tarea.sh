#!/bin/bash
echo "	------------------------------------------------	"
echo "	BIENVENIDO AL ADMINISTRADOR AUTOMATICO DE TAREAS	"
echo "	------------------------------------------------	"
echo ""
echo "	Seleccione una de las siguientes opciones: 		"
echo " 		1- Ver Fecha y hora del sistema.		"
echo "		2- Usuarios conectados.				"
echo " 		3- Ver contenido de una carpeta.		"
echo "		4- Existencia de usuarios en el sistema.	"
echo "		5- Mostrar version del sistema.			"
echo " 		6- Ver procesos activos en el sistema.		"
echo " 		7- Ver uso de memoria RAM y SWAP.		"
echo "		8- Limpiar el historial.			"
echo "		9- Ver calendario del año.			"
echo "		10- Buscar actualizaciones de sistema (SUPER)	"
echo ""
read -p  "	Opcion: " opcion
case $opcion in
	1)
		echo "	Reloj del sistema.	";
		FECHA=(`date +%Y-%M-%d_%H-%m-%S`)
		echo  "	A fecha: $FECHA	";
		;;
	2)
		echo "	Usuarios conectados.	";
		USERS=(`last`)
		FAILACCESS=(`lastb`)
		YO=(`who`)
		echo ""
		echo "	Los usuarios que estan conectados son: $USERS	";
		echo ""
		echo "	Usuarios que fallaron en el acceso: $FAILACCESS	";
		echo ""
		echo "	Mi usuario es: $YO				";
		;;
	3)
		echo "	Contenido de carpeta.	";
		read -p "  Introduzca el nombre de la carpeta " carpeta
		VER=(`ls $carpeta`)
		echo "	El contenido de la carpeta: $VER ";
		;;
	4)
		echo "	Usuarios en el sistema.	";
		USERSYS=(`cat /etc/passwd`)
		echo "	Los usuarios que hay en el sistema son: ";
		echo "	$USERSYS ";
		;;

	5)
		echo "Mostrando version del sistema. ";
		VERSION=(`cat /etc/issue`)
		echo " Resultado: $VERSION";
		;;
	6)
		echo "	Procesos activos del  sistema.	";
		PROC=(`top`)
		echo "	Los procesos activos en el sys son: $PROC ";
		;;
	7)
		echo "	Uso de memoria RAM y SWAP.	";
		RAM=(`free`)
		echo "	El uso de su memoria es: $RAM	";
		;;
 	8)
		echo " Borrar el historial."
		HIST=(`history -c`)
		echo "		Borrando historial ... 		";
		;;
	9)
		echo "	Ver el calendario de año.	"
		CALENDAR=(`open calendario`)
		echo "	CALENDARIO	";
		echo " $CALENDAR	";
		;;
	10)
		echo "	ACTUALIZAR SISTEMA...	";
		UPDSYS=(`sudo apt-get update `)
		UPGSYS=(`sudo apt-get upgrade`)
		echo " Actualizando repositorios del sistema $UPDSYS";
		echo " Comparando las versiones instaladas en el sistema $UPGSYS";
		;;


esac

