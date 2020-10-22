#!/bin/bash
echo "	-------------------------------------------------	"
echo "	BIENVENIDO A LA MAQUINA EXPENDEDORA DE CONFIANZA	"
echo "	-------------------------------------------------	"
echo "		1. Refresco - 1.00 Euro	"
echo "		2. Sandwicht - 3.00 Euros	"
echo "		3. Patatas - 2.00 Euros	"
echo "		4. Café	- 1.00 Euros	"
echo "		5. Zumo - 2.00 Euro	"
echo ""
read -p "Introduzca una de las opciones: " OP
read -p "Introduzca importe: " IMP
case $OP in
	1)
		precio=1
	;;
	2)
		precio=3
	;;
	3)
		precio=2
	;;
	4)
		precio=1
	;;
	5)
		precio=2
	;;
	*)
		echo "Opcion no válida" 
esac
while [ $IMP  -lt $precio ]; do
	falta=`expr $precio - $IMP`
	read -p "	INTRODUZCA $falta EUROS, por favor	" MAS
	IMP=`expr $IMP + $MAS`
done
if [ $IMP -gt $precio ]; then
	cambio=`expr $IMP - $precio`
	echo "	--------------------------------------------------	"
	echo "	Gracias por su compra, por favor recoja su cambio.	"
	echo "			$cambio Euros				"
	echo "	--------------------------------------------------	"
else 
	echo "  ------------------------------------	"
	echo "	Gracias por su compra. Buen provecho	"
	echo "		Que tengas buen día.		"
	echo "	------------------------------------	"
fi

