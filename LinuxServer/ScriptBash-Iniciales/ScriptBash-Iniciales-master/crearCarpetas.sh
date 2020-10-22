#!/bin/bash
read -p "¿Cuántas carpetas quieres crear?" num
cont=0
while [ $cont -lt $num ]
do
	read -p "Introduce nombre para la nueva carpeta: " carp
	if [ -d $carp ]; then
		echo No es posible realizar esta acción, $carp ya existe
	else
		mkdir $carp
		echo carpeta $carp creada
	fi

	cont=`expr $cont + 1`
done

