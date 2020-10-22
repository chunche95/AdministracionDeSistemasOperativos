#!/bin/bash

ip1=$(hostname -I | cut -d ' ' -f '1')
rm archivos/user2.lst
sqlplus user2/user2@$ip1/asir<<EOF
-- Guarda cambios user2
commit;
select * from user1.pruebas;
EOF