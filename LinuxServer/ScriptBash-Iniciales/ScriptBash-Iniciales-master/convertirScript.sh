#!/bin/bash 
read -p "Introduce fichero: " fich
if [ -f $fich -a -x $fich ]; then
	echo $fich es un script
else 
	echo $fich no es un script
fi
touch $fich.sh
chmod u+x $fich.sh
if [ -f $fich.sh -a -x $fich.sh ]; then
	echo $fich es un script
else 
	echo $fich no es un script
fi
