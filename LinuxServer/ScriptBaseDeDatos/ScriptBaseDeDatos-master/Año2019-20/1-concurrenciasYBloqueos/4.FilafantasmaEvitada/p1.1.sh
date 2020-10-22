#!/bin/bash

ip1=$(hostname -I | cut -d ' ' -f '1')
rm archivos/p1.1.lst
sqlplus p1/p1@$ip1/asir<<EOF
spool archivos/p1.1.lst
delete from pruebas where numero=3;
rollback;
EOF

cat archivos/p1.1.lst >> archivos/p1.lst
rm archivos/p1.1.lst 