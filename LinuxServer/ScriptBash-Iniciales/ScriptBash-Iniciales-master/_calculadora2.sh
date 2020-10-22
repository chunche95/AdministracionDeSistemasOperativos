#!/bin/bash
echo "BIENVENIDO A CALCULADORA LINUX, USANDO CASE "
FECHA=(`date +%Y-%M-%d_%H-%m-%S`)
echo  " A fecha: $FECHA "
		echo "	-------------------"
		echo "	|  CALCULADORA	  |"
		echo "	-------------------"
		echo "	-------------------"
                echo "	|1-Suma           |"
                echo "	|2-Resta          |"
                echo "	|3-Multiplicación |"
                echo "	|4-División       |"
     		echo "	|5-Comparador(>)  |"
		echo "	|6-Comparador(<)  |"
		echo "	|7-Comparador(=)  |"
		echo "	|8-Exponente	  |"
		echo "	|9-SALIR	  |"
		echo "	-------------------"
		echo ""
read -n 9 -p "Introduzca una opcion: " OPC

	
	read -p " Introduzca el primer número: " N1
	read -p " Introduzca el segundo número: " N2
case $OPC in
	1)
		echo "	-- Suma --	";
		SUMA=(`expr "$N1" + "$N2"`)
		echo "	La suma es: $SUMA";
		echo"";
		;;
	2)
		echo "	-- Resta --	";
		RESTA=(`expecho "  |9-Primos         |"
r "$N1" - "$N2"`)
                echo "	La resta es: $RESTA";
                echo"";
                ;;

	3)
		echo "	-- Multiplicación --	";
		MULTI=(`expr "$N1" \* "$N2"`)
                echo "	La multiplicación es: $MULTI";
                echo"";
                ;;

	4) 
		echo "	-- División --	";
		DIVI=(`calc "$N1" / "$N2"`)
                echo "	La división es: $DIVI";
      		echo "";
                ;;

	5)
		echo "	-- Comparador --	 ";
		COMP=(`expr "$N1" < "$N2"`)
		echo "	$N1 es menor que $N2";
		;;
	6)
		echo "  -- Comparador --         ";
                COMP=(`expr "$N1" > "$N2"`)
                echo "  $N1 es mayor que $N2";
                ;;
	7)
		echo "  -- Comparador --         ";
                COMP=(`expr "$N1" = "$N2"`)
                echo "  $N1 es igual que $N2";
                ;;
	8)
		echo "  -- División --  ";
		echo "	N1 elevado a N2	";
                EXPO=(`calc "$N1" ** "$N2"`)
                echo "  El exponente es: $EXPO";
                echo "";
                ;;
	9)
		echo "SALIENDO DEL PROGRAMA...";
		exit;
	
esac


