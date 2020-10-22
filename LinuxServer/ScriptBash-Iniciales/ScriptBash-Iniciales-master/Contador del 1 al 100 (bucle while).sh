#!/bin/bash

cont=0
while [ $cont -le 100 ]
do
	echo $cont
	cont=`expr $cont + 2`
done
