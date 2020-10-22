#!/bin/bash
for i in `cat lista.txt`;
do
	ping -c 1 $i &> /dev/null
	if [ $? -eq 0 ]
		then
			nmap -p 80 $i | grep "80\/tcp open" &> /dev/null
		if [ $? -eq 0 ]
			then
				echo $i SI tiene servidor web en el 80
			else 
				echo $i NO tiene servidor wbe en el 80
		fi
	fi
done
