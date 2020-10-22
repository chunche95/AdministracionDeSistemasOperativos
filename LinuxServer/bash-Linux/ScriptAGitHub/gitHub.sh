#!/bin/bash

git status

git config --global alias.nota 'commit -m'
git config --global alias.sube 'push origin master'


git add ../Códigos/. &&
git nota "Códigos de programas y servicios del sistema " &&
git sube
echo "Códigos terminado"

git add ../-Ejercicios/. &&
git nota "Códigos de ejercicios realizados " &&
git sube
echo "Ejercicios terminado"

git add ../-Examenes/. &&
git nota "Códigos de exámenes realizados " &&
git sube
echo "Examenes terminado"

git add ../Imagenes/. &&
git nota "Introducción a Scripts de Bash en GNU Linux" &&
git sube
echo "Imágenes terminado"

git add ../README.md &&
git nota "Introducción a Scripts de Bash en GNU Linux" &&
git sube
echo "readme terminado"

git add ../Script de servicios del sistema.sh &&
git nota "Script All in One the services and process of GNU" &&
git sube
echo "Script terminado"


git add ../. &&
git nota "Archivos subidos" &&
git sube
echo "Terminado"
sleep 5
clear