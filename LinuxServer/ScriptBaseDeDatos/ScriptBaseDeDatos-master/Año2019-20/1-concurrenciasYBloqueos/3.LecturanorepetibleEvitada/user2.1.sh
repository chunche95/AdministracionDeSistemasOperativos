#!/bin/bash

ip1=$(hostname -I | cut -d ' ' -f '1')
rm archivos/user2.lst
sqlplus user2/user2@$ip1/asir<<EOF
spool archivos/user2
update user1.pruebas set nombre='SERIALIZABLE-EL-ULTIMO' where numero=3;
spool off
EOF