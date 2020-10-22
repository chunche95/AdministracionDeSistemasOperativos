#!/bin/bash
read -p "Introduce un script: " scr
	while [ ! -x $scr ] || [ ! -f $scr ]
	do
		read -p "Esto no es un script, introduce otro: " scr
	done
	
`chmod ugo-x $scr`
echo $scr ha dejado de ser un script
