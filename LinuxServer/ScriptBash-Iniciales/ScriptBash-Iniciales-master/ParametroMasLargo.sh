#!/bin/bash 
fich1=$1
while [ ! -f $fich1 ]
do
	read -p "$fich1 no es un fichero, introduce otro: " fich1
done

fich2=$2
while [ ! -f $fich2 ]
do
	read -p "$fich2 no es un fichero, introduce otro: " fich2
done
contFich1=0
	for var in `cat $fich1`
	do
		contFich1=`expr $contFich1 + 1`
	done
#aquí sabemos cuántas palabras tiene fich1, se guardan contFich1

contFich2=0
	for var in `cat $fich2`
	do
		contFich2=`expr $contFich2 + 1`
	done
#aquí sabemos cuántas palabras tiene fich2, se guardan contFich2
if [ $contFich1 -gt $contFich2 ]; then
	echo $fich1 tiene más palabras que $fich2, $contFich1 frente a $contFich2
elif  [ $contFich1 -lt $contFich2 ]; then
	echo $fich2 tiene más palabras que $fich1, $contFich2 frente a $contFich1
else 
	echo $fich1 tiene las mismas palabras que $fich2, $contFich2 concretamente.
fi

