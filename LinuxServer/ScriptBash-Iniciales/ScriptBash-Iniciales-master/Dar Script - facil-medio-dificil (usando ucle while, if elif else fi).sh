#!/bin/bash

echo 'Introduce el script'
read fich

while [ ! -x $fich ] || [ ! -f $fich ]
do
    echo 'Introduce el script'
    read fich
done

cant=`cat $fich | wc -l`
echo 'El fichero '$fich' tiene '$cant' lineas'

if [ $cant -le 10 ]; then
    echo 'Es un script fácil'
elif [ $cant -ge 20 ]; then
    echo 'Es un script dificil'
else
    echo 'Es un script medio'
fi