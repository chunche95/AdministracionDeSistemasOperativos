#!/bin/bash 
#Introduce el nombre y la edad
read -p "Introduce tu nombre:" nombre
read -p "Introduce tu edad:" edad
#cacular año nacimiento
echo "$nombre tu año de nacimiento es `expr 2018 - $edad`"


