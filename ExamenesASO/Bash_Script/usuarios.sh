#!/bin/bash
oldIFS=$IFS

IFS=$'\n'
for linea in `cat usuarios.txt`
do
	usuario=`echo $linea | cut -f2 -d:`
echo $usuario
echo "$usuario:temporal" | chpasswd
done:q!
IFS=$old_IFS
