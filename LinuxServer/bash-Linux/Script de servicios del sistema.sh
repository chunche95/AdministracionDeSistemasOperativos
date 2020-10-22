#!/bin/bash             
##########################################################
# ADMINISTRACION DE SISTEMAS INFORMATICOS EN RED.        #
#                                                        #
# Script que muestra un menu tipo utilizando funciones   #
#                                                        #
# @autor: Pauchino                                       #
# @version: 1.0                                          #
##########################################################
trap '' 2
clear
echo " Ejercicios BASH para ver los procesos en funcionamiento. "

# Declaracion de las funciones.

 todoservicios() {
    echo " Estos son los 10 procesos lanzados en el sistema:" 
    ps -aux | head -10 
    read -p "Pulse ENTER para salir" ENTER
}
 modosimple() {
    echo " Estos son los servicios lanzados con el comando TOP bajo criterio: " 
    top | head -10
    read -p "Pulse ENTER para salir" ENTER
}
 serviciousandopuerto() {
    echo " Estos son los servicios que estan usando un puerto en estos momentos:" 
    nmap localhost
    read -p "Pulse ENTER para salir" ENTER
}
 procesosalumno() {
    echo " Los procesos que lanza el usuario ALUMNO en su sesión son:" 
    ps -u alumno -U alumno -j | head -10
    read -p "Pulse ENTER para salir" ENTER
}
 verarbol() {
    echo " Este es el arbol de procesos, es similar a lanzar un ps f." 
    pstree
    read -p "Pulse ENTER para salir" ENTER
}
 llamadasistemaproceso() {
    echo " Esta es la muestra a la llamada del proceso NMAP, usamos strace:" 
    strace nmap
    read -p "Pulse ENTER para salir" ENTER
}
 sshlocal() {
    echo " Va a conectarse por SSH a su propio PC:" 
     sudo apt -sy install openssh-server
    ssh ${USER}@127.0.1.1
    read -p "Pulse ENTER para salir" ENTER
}
 monitorsistemagnome() {
    echo " Se va a lanzar el monitor de sistema gnome:" 
    gnome-system-monitor
    read -p "Pulse ENTER para salir" ENTER
}
 rendimientocpu() {
    echo " Este es el rendimiento de cada CPU:" 
    mpstat
    read -p "Pulse ENTER para salir" ENTER
}
 lecturapuerto() {
    echo " Se realizará una lectura en tiempo real del usuario alumno por el puerto 22:" 
    sudo tcpdump -Z alumno
    read -p "Pulse ENTER para salir" ENTER
}
 borrartemporalesalapagar() {
    echo " Se borraran los archivos temporales del equipo:" $(sudo rm -fr /tmp/* )
    echo " Apagando el sistema ... #" 
    sudo init 0
    read -p "Pulse ENTER para salir" ENTER
}
 buscardirectorioconSETGID() {
    echo " Busca todos los archivos y directorios que tengan seteado el SGID (grupos) igual a 2:" 
    find /bin -perm -2000
    read -p "Pulse ENTER para salir" ENTER
}
 archivosmodificadosenxmes() {
    echo " Buscar archivos modificados en un Noviembre del año 2018 :" 
    find /etc -type f -printf "%Cm-%CY %p\\n" | grep "^11-2018"
    read -p "Pulse ENTER para salir" ENTER
}
 manipularimagenesencarpeta() {
    echo " Cambiar imagenes .jpg a .png de la carpeta actual:" 
    mogrify -format png *.jpg
    read -p "Pulse ENTER para salir" ENTER
    echo " Convertir una imagen PNG en JPG indicando la calidad de conversión." 
    convert -quality 96 image.png image.jpg
}
 guardarhistorialdeterminal() {
    echo " Se procedera a guardar todos los comandos usados en terminal en historyX.txt :"
    history -w ~/history1.txt
    read -p "Pulse ENTER para salir" ENTER
}
 pararservicio() {
    read -p "Introduce el servicio que desea detener:" serv 
    service $serv stop
    read -p "Pulse ENTER para salir" ENTER
}
 iniciarservicio() {
    read -p "¿Qué servicio desea iniciar?" serv
    service $serv start
    read -p "Pulse ENTER para salir" ENTER
}
 estadoservicio() {
    read -p "¿De qué servicio quieres ver el estado?" serv
    service $serv status
    read -p "Pulse ENTER para salir" ENTER
}
 subirprioridad() {
    read -p "Escriba el PID del procesos que desea SUBIR su prioridad" sube
    renice -20 $sube
    read -p "Pulse ENTER para salir" ENTER
}
 bajarprioridad() {
    read -p "Escriba el PID del proceso que desea BAJAR su prioridad" baja
    renice 19 $baja
    read -p "Pulse ENTER para salir" ENTER
}
 comprimir() {
    read -p "Introduzca el usuario para duardar su home" usuario
    echo " ########### Empaquetando /home/$usuario ##########"
    tar cvf /tmp/$usuario.tar /home/$usuario
    echo " ########### Comprimiendo archivo ... ############"
    gzip /tmp/$usuario.tar
     read -p "Pulse ENTER para salir" ENTER
}
 pingaips() {
    read -p "Introduzca el archivo con las IPS" $1  
if [ "$1" = "" ] ; then  # No se pasó una lista de ips
   echo " Error: Por favor introduce un nombre de archivo válido, que contenga las direcciones IP para hacer ping."
exit 1
fi
if [ ! -f "$1" ] ; then  # Archivo inválido.
   echo " Error: No puedo encontrar el archivo "$1"."
exit 2
fi
echo " (*) Haciendo ping a los servidores contenidos en el archivo "$1", por favor espere..."
echo ""
while read IP
do
   ping -c 3 "$IP" >& /dev/null
   
 if [ "$?" != "0" ] ; then   
 # Houston, tenemos un problema.
   (echo -n "$IP  " ; date) | tee -a noping.log
   echo -e     "${IP} !!! \e[0;31m[X]\e[1;37m"
   nmap "$IP"
 else echo -e  "$IP \e[1;32m[OK]\e[1;37m"
 fi
done < "$1"
echo ""
echo "Listo!!!"
    
}
 nmappuerto80() {
     echo " Haciendo lectura del puerto local 80."
     nmap -p 80 hostname.domainname.com
}
 crearusuarios() {
    for usuario in `cat usuarios.txt`
do
    usuario =`echo  $usuario | cut -d":" -f2`
    nombre=`echo  $usuario | cut -d":" -f4`
    apellido=`echo  $usuario | cut -d":" -f3`
    nombapel=$apellido", " $nombre
    useradd $usuario -p `mkpasswd temporal` -c $nombapel -d /home/$nombre
done  
IFS=$old_IFS  
}
 borrarusuarios() {
    IFS=$'\n'
for i in `cat usuarios.txt`
do
    usuario=`echo $i | cut -d":" -f2`
    deluser $usuario
done 
IFS=$old_IFS 
}

# PROGRAMA PRINCIPAL
INICIO=0
while true
do
    clear
    echo "          Menu de servicios ADMINISTRACION LINUX."
    echo "--------------------------------------------------------------------"
    echo "1) todo servicios                    2) modo simple"
    echo "3) servicio usando puerto            4) procesos alumno"
    echo "5) ver arbol                         6) llamada sistema proceso"
    echo "7) ssh local                         8) monitor sistema gnome"
    echo "9) rendimiento cpu                   10) lectura puerto"
    echo "11) borrar temporales al apagar      12) buscar directorio con SETGID"
    echo "13) archivos modificados en 'x' mes  14) manipular imagenes en carpeta"
    echo "15) guardar historial de terminal    16) parar servicio"
    echo "17) iniciar servicio                 18) estado servicio"
    echo "19) subir prioridad                  20) bajar prioridad"
    echo "21) comprimir                        22) ping a ips"
    echo "23) nmap puerto 80                   24) crear usuarios"
    echo "25) borrar usuarios                "
    echo ""
    echo "0) salir"
    echo "--------------------------------------------------------------------"
    read opcion
    case $opcion in
    1) todoservicios;;
    2) modosimple;;
    3) serviciousandopuerto;;
    4) procesosalumno;;
    5) verarbol;;
    6) llamadasistemaproceso;;
    7) sshlocal;;
    8) monitorsistemagnome;;
    9) rendimientocpu;;
    10) lecturapuerto;;
    11) borrartemporalesalapagar;;
    12) buscardirectorioconSETGID;;
    13) archivosmodificadosenxmes;;
    14) manipularimagenesencarpeta;;
    15) guardarhistorialdeterminal;;
    16) pararservicio;;
    17) iniciarservicio;;
    18) estadoservicio;;
    19) subirprioridad;;
    20) bajarprioridad;;
    21) comprimir;;
    22) pingaips;;
    23) nmappuerto80;;
    24) crearusuarios;;
    25) borrarusuarios;;
    0) clear; echo "Fin de programa. Saliendo ... ";sleep 2; break;;
    *)echo " Opcion no valida.";
	echo " Pulse Enter para continuar"; read ENTER ;;
    
    esac
done