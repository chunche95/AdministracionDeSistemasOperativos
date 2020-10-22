#!/bin/bash 
contador=-1
while [ $contador -lt 10 ]
do 
contador=`expr $contador + 1`
tabla=`expr $1 \* $contador`
echo $1 x $contador=$tabla
done

