#!/bin/bash

# Supongamos que tenemos un fichero llamado libros.txt con los códigos de barras de algunos libros de texto en formato EAN-13, por ejemplo:

# 841234567891,Matemáticas
# 841234561231,Lengua Castellana
# 841211367891,Inglés
# 841234564391,Francés

# Realiza un script que genere para cada libro una imagen de su código de barras, con las siguientes características:

  #  El nombre del fichero se corresponde con la asignatura en minúsculas y sin
  #  caracteres especiales (acentos, espacios, signos de puntuación, etc.)
  #  El formato del fichero de imagen es jpeg
  #  Al final debe mostrar un listado de los ficheros generados


# Ayuda:
# Se pueden utilizar los paquetes barcode e imagemagick para hacer gran  cantidad
# de transformaciones desde la línea de comandos, por ejemplo:barcode -b 841234567891 -e EAN -g 550x386+0+0 -o salida.psconvert salida.ps salida.jpg

existe="libros.txt"
if [ -f $existe ];
then
	echo "Fichero 'libros.txt' encontrado"
	(cat libros.txt | cut -d"," -f 1) > codes
#	cat codes
	for line in $(cat codes); do
		echo "Creando: $line" ;
		barcode -b $line -e EAN -g 550x3686+0+0 -o $line.psconvert $line.ps $line.jpg
	done
else
	echo "Fichero NO encontrado!"
fi
