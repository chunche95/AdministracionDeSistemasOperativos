#!/bin/bash

# Enviar un email desde un script con el resumen de una copia de seguridad.
#
# El primer paso es instalar mailutils, este paquete nos permite enviar corres,
# bien desde la línea de comandos, bien mediante script.
#
sudo apt-get install -y mailutils ssmtp

# Configuramos SSMTP
sudo nano /etc/ssmtp/ssmtp.conf<<EOF
# Cambios en fichero de configuracion
root=humancomputing3@gmail.com
mailhub=smtp.gmail.com:587
hostname=humancomputing3@gmail.com

FromLineIverride=YES
UseSTARTTLS=YES
AuthUser=humancomputing3
AuthPass=*******
EOF

# Editamos el script de copias de seguridad que previamente tenemos


# Posteriormente, creamos una variable con un valor, el cual serña el mail de 
# destinarario

ficherolog=/etc/passwd

email="humancomputing3@gmail.com"

# Y para terminar, añadimos la siguiente sentencia:

sudo cat $ficherolog  | mailx -s "Copia de seguridad" $email
