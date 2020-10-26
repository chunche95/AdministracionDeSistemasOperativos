#!/bin/bash
#
# Desinstala por completo si se tiene instalado LibreOffice.
# Se instala LibreOffice 5.0.1 en español con su manual de ayuda correspondiente.
apt-get purge libreoffice* -y
apt-get remove libreoffice*
apt-get autoremove -y

# Creamos una carpeta nueva llamada libreoffice en /tmp 
cd /tmp/
mkdir libreoffice

# Entramos a la carpeta que recien creamos.
cd libreoffice

# Descargamos los tres paquetes deb para tener instlado libreOffice en espanhiol con su respectiva ayuda.
wget -c http://download.documentfoundation.org/libreoffice/stable/5.0.1/deb/x86_64/LibreOffice_5.0.1_Linux_x86-64_deb.tar.gz
wget -c http://download.documentfoundation.org/libreoffice/stable/5.0.1/deb/x86_64/LibreOffice_5.0.1_Linux_x86-64_deb_langpack_es.tar.gz
wget -c http://download.documentfoundation.org/libreoffice/stable/5.0.1/deb/x86_64/LibreOffice_5.0.1_Linux_x86-64_deb_helppack_es.tar.gz

# Descomprimimos.
tar xzvf LibreOffice_5.0.1_Linux_x86-64_deb.tar.gz
cd LibreOffice_5.0.1.2_Linux_x86-64_deb/DEBS/

# Instalamos todos los paquetes deb.
dpkg -i *.deb

# Descomprimimos.
tar xzvf /tmp/libreoffice/LibreOffice_5.0.1_Linux_x86-64_deb_langpack_es.tar.gz
cd LibreOffice_5.0.1.2_Linux_x86-64_deb_langpack_es/DEBS/

# Instalamos todos los paquetes deb.
dpkg -i *.deb

# Descomprimimos.
tar xzvf /tmp/libreoffice/LibreOffice_5.0.1_Linux_x86-64_deb_helppack_es.tar.gz
cd LibreOffice_5.0.1.2_Linux_x86-64_deb_helppack_es/DEBS/

# Instalamos todos los paquetes deb.
dpkg -i libobasis5.0-es-help_5.0.1.2-2_amd64.deb

# Borramos la carpeta donde se encontraban los tres paquetes deb de Libreoffice.
rm -R /tmp/libreoffice
