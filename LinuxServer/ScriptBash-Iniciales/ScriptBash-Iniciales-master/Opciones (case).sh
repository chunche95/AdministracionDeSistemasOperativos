#!/bin/bash

clear
echo ''
echo -e '\e[31m   Elija una de las siguientes opciones:'
echo ''
echo -e '\e[36m      1. Mostrar fecha'
echo '      2. Mostrar el usuario conectado'
echo '      3. Contenido de una carpeta'
echo '      4. Comrpobar si existe un usuario en el sistema'
echo '      5. Usuarios del sistema'
echo '      6. Comprobar la dirección IP'
echo '      7. Calendario'
echo '      8. Algo divertido'

echo -e '\e[0m'

read -n1 -p 'Opción: ' num

echo ''
echo ''

case $num in
	1)
		echo 'Hoy es:'
		date
		;;
	2)
		echo 'Ahora mismo eres:'
		whoami
		;;
	3)
		read -p 'Que carpeta quieres comprobar? ' carpeta
		echo ''
		if [ -d $carpeta ]; then
			echo 'El contenido de la carpeta es:'
			ls -l $carpeta
		else
			echo 'No es una carpeta'
		fi
		;;
	4)
		read -p 'Que usuario quieres comprobar? ' usuario
		echo ''
		existe=`grep $usuario /etc/passwd`
		if [ $existe = '' ]; then
			echo 'No existe el usuario en el sistema'
		else
			echo 'Si existe el usuario en el sistema'
		fi
		;;
	5)
		usus=`cat /etc/passwd | grep -i bash | wc -l`
		echo 'En el sistema hay '$usus' usuarios'
		cat /etc/passwd | grep -i bash | cut -d ":" -f1
		;;
	6)
		echo 'La IP es:'
		hostname -I
		;;
	7)
		read -p 'Que mes quieres ver? ' mes
		read -p 'Que año quieres ver? ' anio
		echo ''
		cal $mes $anio
		;;
	8)
		echo -e '\e[32m                  ___'
		echo '                 /   \'
		echo '          \m/  (| ^_^ \) \m/'
		echo '           |     |   |    |'
		echo '           \_____|   |____|'
		echo '                 |   |'
		echo '                 |   |'
		echo '                 | _ |'
		echo '                /     \'
		echo '               /       \'
		echo '              |         |'
		echo -e '             _|         |_ \e[0m'
		;;
	*)
		echo -e '\e[94m Opción no válida \e[0m'
		echo ''
		sleep 2
		./ejercicio4.sh
esac

echo ''
echo 'Presiona Enter para salir'

read -s pepe

clear
