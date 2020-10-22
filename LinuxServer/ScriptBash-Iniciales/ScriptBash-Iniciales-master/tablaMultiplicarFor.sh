#!/bin/bash 
digito=$1
for var in {0..10}
do 
tabla=`expr $digito \* $var`
echo $digito x $var=$tabla
done

