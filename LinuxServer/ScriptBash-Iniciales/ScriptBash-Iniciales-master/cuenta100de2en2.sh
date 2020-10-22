#!/bin/bash 
contador=0
while [ $contador -lt 100  ]
do 
contador=`expr $contador + 2`
echo $contador
done

