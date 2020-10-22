#!/bin/bash

clear

function menu() {
	# Listar los directorios
	dir=$(ls)
	# Contar numero de directorios existentes
	contador=0
	# Bucle que añade los numeros
	for i in $dir
	do
		# Listo los elementos que hay dentro
		echo -e "\n"		
 		echo $contador $i
		let contador++

	done

}
# menu --> Funciona ya lista los directorios
# var=$($menu | cut -d"." -f"1")
# echo $var
function pantalla() {
 # Crea un display de los directorios de la funcion menu() en un box whiptail de 22x55
  box=$(whiptail --title "Menu Directorios" --menu "Seleccione uno" 22 55 15 $(menu) 3>&1 1>&2 2>&3)
}

# Llamada de la funcion pantalla y la muestra por pantalla
 pantalla 

 
# Seleccion del nombre de la segunda columna y la guardo para después hacerle el 'less'
function selecOpcion(){
	# Almaceno el número de directorios 
	numeroDirectorios=$(ls | wc -l)
	# Listo directorios junto con un numero empezando del 1 al n.
	if [ $box -lt $numeroDirectorios ]
	then
		# Bucle que lista (en numero) todos los directorios de la carpeta actual
		vuelta=-1
		while [ $vuelta -lt $numeroDirectorios ]
		do
		
		# Lista directorio con un número
		for i in $(ls);
		do		
			let vuelta+=1
			# echo $vuelta $i
			# echo $vuelta
			quienLeo=$i
			# Fichero o directorio que debe aplicarse el less
			# echo "============"
			# echo "$quienLeo"
			# echo "============"
			
			if [ $box -eq $vuelta ]
			then
				less $quienLeo
				# echo "Fin"
			#else
			#	echo "A pensar más chato"
			fi

		done 
		done
	# ########################################################################

		# Compara numero del directorio con el numero seleccionado en el box
		echo "............"
		echo "  Entradas  "
		echo "............"
		echo "Selección: $box" 
		echo "............"
		echo "+++++++++++++++++++++++++++++"
 		echo "Directorio seleccionado: $box" # Numero del directorio seleccionado
 		echo "+++++++++++++++++++++++++++++"
		echo "****************************************"
 		echo "Nº de archivos totales encontrados: $numeroDirectorios" # Numero de directorios & ficheros
 		echo "****************************************"
		
		
		
	else
		echo "JAJA! No sale"
	fi
    # if [ $menu != null ] # --> Pte de ver como coger el valor de la 2da columna => Directorio
    # then
	# 	var=$(sort -k2 $(menu))
	# 	echo $var
    # else
    #     echo "No hay coincidencia"
    # fi
}

selecOpcion


#function hacerLess(){
# less $(pantalla)
#}
#hacerLess
echo -e "\n"
echo -e "\e[33m Fin de script \e[0m"	

