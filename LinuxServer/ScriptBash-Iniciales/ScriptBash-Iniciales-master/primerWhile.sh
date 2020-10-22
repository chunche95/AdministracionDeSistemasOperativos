#!/bin/bash 
read -p "Desea continuar? (s/n)" resp
while [ $resp = s ]
do 
	echo continuamos
	read -p "Quieres continuar? (s/n)" resp
done
echo no seguimos
#creamos el contador
cont=0
while [ $cont -lt 5 ]
do 
echo $cont
cont=`expr $cont + 1`
done
