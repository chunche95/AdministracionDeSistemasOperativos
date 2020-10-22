#!/bin/bash 
#un script que pida tu nombre, edad y ciudad donde vives
#pedir nombre
read -p "Introduce tu nombre:" nombre
#pedir edad
read -p "Introduce tu edad:" edad
#pedir ciudad
read -p "Introduce la ciudad donde vives:" ciudad
#mostrar los datos obtenidos
echo "Hola $nombre, tienes $edad años y vives en $ciudad."

