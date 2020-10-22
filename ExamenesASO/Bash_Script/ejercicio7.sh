#!/bin/bash
echo -e "\e[1;3m ---------Bienvenido al Script de lectura de los '.conf' de /etc -------- \e[0m"
sleep 5
echo "Accedemos a la ruta /etc/"
cd /etc/
echo "Buscamos los ficheros '.conf y los alamcenamos en un fichero temporal'"

ls | grep .conf > /tmp/ficherosConf.txt

echo "Leemos el fichero temporal linea a  linea y cada linea lee el fichero"
for line in $(cat /tmp/ficherosConf.txt);
do
    clear
    echo -e "\e[43m Leyendo: $line \e[0m"
    echo ""
    echo ""
    cat $line
    echo ""
    echo ""
    echo -e "\e[4;3m Ha leido:  $line \e[0m"
    echo -e "\e[45m Pulse para continuar \e[0m "
    read nada
done
clear
echo "Eliminamos el fichero temporal del sistema"
rm -d /tmp/ficherosConf.txt
echo -e "\e[44m Eliminado \e[0m"
read -p "Pulse para salir" continuar
       
exit
