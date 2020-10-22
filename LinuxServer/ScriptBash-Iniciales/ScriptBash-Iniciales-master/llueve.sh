#!/bin/bash 
#realizar un script que pregunte si llueve, si la respuesta es "si" contestaremos me quedo en casa. Si la respuesta es no contestaremos salgo a la calle
read -n1 -p "¿Esta lloviendo? s/n " resp
echo
if [ $resp != n ]; then
	echo "Me quedo en casa"
else 
	echo "Salgo a la calle"
fi 
