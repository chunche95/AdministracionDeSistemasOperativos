#!/bin/bash
j=0;
i=0;

while [ $i -lt 10 ]
do
	while [ $j -lt 3 ]
	do
		grep -wine "ERROR" -wine "Warning"  /var/log/syslog >> pau.txt
		j=$[$j+1]
		echo "########### HECHO $J #############"
		
		i=$[$i+1]
		echo $i "...Echo!"

	done

done
