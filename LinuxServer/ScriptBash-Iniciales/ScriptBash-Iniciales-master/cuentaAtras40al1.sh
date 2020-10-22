#!/bin/bash 
contador=41
while [ $contador -gt 1 ]
do 
contador=`expr $contador - 1`
echo $contador
done

