#!/bin/bash 
read -p "Introduce nombre de usuario: " usu
esta=`cut -d":" -f1 /etc/passwd |  grep ^$usu$ | wc -l`
while [ $esta -eq 0 ]
do
	read -p "Introduce un nombre de usuario valido: " usu
	esta=`cut -d":" -f1 /etc/passwd |  grep ^$usu$ | wc -l`
done

cont=0 
carpPer=`grep ^$usu /etc/passwd | cut -d":" -f6`
cd $carpPer
for var in `ls` 
do 
	if [ -d $var ]; then
		cont=`expr $cont + 1`
	fi
done
echo "El usuario $usu tiene en su carpeta personal $cont directorios"
