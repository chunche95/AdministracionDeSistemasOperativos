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
 		echo $contador. $i
		let contador++

	done

}
#menu --> Funciona ya lista los directorios

var=$($(menu) | awk'{print $2}')
echo $var


function pantalla() {
 # Crea un display de los directorios de la funcion menu() en un box whiptail de 22x55
  whiptail --title "Menu Directorios" --menu "Seleccione uno" 22 55 15 $(menu) 
}

# Llamada de la funcion pantalla y la muestra por pantalla
pantalla

# Seleccion del nombre de la segunda columna y la guardo para después hacerle el 'less'
function selecOpcion(){
     if [ $(pantalla) == $(?) ] # --> Pte de ver como coger el valor de la 2da columna => Directorio
     then
	var=$(sort -k 2 $(menu))
	echo $var
     else
        echo "No hay coincidencia"
     fi
}

selecOpcion


#function hacerLess(){
# less $(pantalla)
#}
#hacerLess
echo -e "\n"
echo "Fin de script"	

