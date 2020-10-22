#!/bin/bash
ip1=$(hostname -I | cut -d ' ' -f '1')
ip2=$(hostname -I | cut -d ' ' -f '1')
ip3=$(hostname -I | cut -d ' ' -f '1')
clear
# Sentencias bloqueadas por usuario bloqueante
echo "      SCRIPT 2        "
echo "-------------------------------------"
echo $ip1
echo "-------------------------------------"
sqlplus bloqueante/bloqueante@$ip1/asir<<EOF
host echo '---------------'
show user
host echo '---------------'
host echo '+++++++++++++++'
host echo '|||||||||||||||'
host echo '|||||||||||||||'
host echo 'vvvvvvvvvvvvvvv'
host sleep 2

EOF

sleep 5
clear

echo "-------------------------------------"
echo "          SCRIPT 2 TERMINADO         "
echo "-------------------------------------"
echo ""
echo ""
echo "VER FICHERO LECTURA-NO-REPETIBLE.lst"