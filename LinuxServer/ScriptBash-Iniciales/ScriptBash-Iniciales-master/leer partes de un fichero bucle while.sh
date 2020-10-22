#!/bin/bash

read -p 'Introduce el fichero ' fich

while [ ! -f $fich ]
do
	echo 'Fichero no válido'
	echo ''
	read -p 'Introduce el fichero ' fich
done

ls -l $fich | cut -d" " -f1

