#!/bin/bash 

read -p "Introduce un usuario: " usu

#validacion
existe=`cut -d":" -f1 /etc/passwd | grep ^$usu$ | wc -l`
while [ $existe -eq 0 ]
do
	read -p "Usuario no existe. Introduce un usuario: " usu
	existe=`cut -d":" -f1 /etc/passwd | grep ^$usu$ | wc -l`
done

carpeta=`grep ^$usu /etc/passwd | cut -d":" -f6`
echo La carpeta personal de $usu es $carpeta
