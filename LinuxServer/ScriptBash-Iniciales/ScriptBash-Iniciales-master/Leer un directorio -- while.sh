#!/bin/bash

read -p 'Dime el directorio ' dir
echo ''

while [ ! -d $dir ]
do
	echo 'Introduce un directorio válido'
	read -p 'Dime el directorio ' dir
done

ls -l $dir
