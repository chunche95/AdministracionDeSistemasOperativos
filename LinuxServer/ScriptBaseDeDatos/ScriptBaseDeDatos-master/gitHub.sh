#!/bin/sh

clear
git pull
clear
echo "+--------------------------+"
echo "| Añadiendo archivos a git |"
echo "+--------------------------+"
sleep 2
git add gitHub.sh &&
git commit -m "Script de subida de archivos al repo" &&
git push origin master

echo "_# 0%"
git add 1-Apuntes/. &&
git commit -m "Apuntes de Base de Datos 2" &&
git add Año2018-19/. &&
git push origin master
echo "**************"
echo "Apuntes ==> OK"
echo "**************"
echo ""
echo "___________# 25%"
echo ""
git commit -m "Script iniciales de bases de datos en Centos 7 - 2018/19" &&
git push origin master
echo "**************"
echo "2018-2019 ==> OK"
echo "**************"
git add Año2019-20/. &&
git commit -m "Script de Base de Datos Oracle en Centos 7 - 2019/20" &&
git push origin master
echo ""
echo "______________________# 50%"
echo ""
echo "**************"
echo "2019-2020 ==> OK"
echo "**************"
git add . &&
git commit -m "Otros archivos - Subidos" && 
git push origin master 
sleep 5
echo ""
echo "_________________________________# 75%"
echo ""
git add --all &&
git commit -m "Organizando archivos" &&
git push origin master
git status
echo ""
echo ""
echo "+--------------------------+"
echo "|     Trabajo terminado    |"
echo "+--------------------------+"
echo ""
echo "____________________________________________# 100%"
echo ""
read -p "Limpiar pantalla (Y/N)" resp
case $resp in
    Y) clear;;
    y) clear;;
    N) sleep 2; echo "OK!";;
    n) sleep 2; echo "OK!";;
    *) echo "Opción no válida";;
esac
