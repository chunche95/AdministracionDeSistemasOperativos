#!/bin/bash 
read -p "Introduce nombre de usuario: " usu
#añadimos wc para que nos devuelva un numero distinto de 0 si este existe y no nos muestre un error en caso contrario
usu_sis=`grep -i ^$usu /etc/passwd | cut -d ":" -f1 | wc -c`
#ponemos la siguiente condicion porque siempre que nos devuelva algo la variable es porque el usuario existe
if [ $usu_sis -ne 0 ]; then
	echo $usu está en el sistema
else
	echo $usu no está en el sistema
fi
