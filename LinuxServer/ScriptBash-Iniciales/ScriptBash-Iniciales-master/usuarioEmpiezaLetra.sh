#!/bin/bash 
#mostrar usuarios que empiezan por la letra introducida
#Introducir letra
read -n1 -p "Introduce la primera letra del usuario a buscar:" letra
#usuarios que empiezan por letra
echo "Los usuarios que empizan por la letra $letra son: "
grep -i ^$letra /etc/passwd | cut -d":" -f1


