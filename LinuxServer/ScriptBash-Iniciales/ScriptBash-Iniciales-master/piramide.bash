#!/bin/bash
clear
echo "Esta es la piramide hasta $1:"

for (( i=1; i<=$1; i++ ))
do
	for (( j=1; j<=i; j++ ))
	do
		echo -n "$i"
	done
	echo ""
done
