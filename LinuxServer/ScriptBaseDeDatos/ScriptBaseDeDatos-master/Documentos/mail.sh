#!/bin/sh
sh variables.sh

sqlplus -s / as sysdba <<EOF
set colsep','
set pagesize 11
set trimspool on
set headsep off
set linesize 1000
spool TablaBermudez.cvs

select sistema, avg(tamano), avg(usado), montado
from DF
group by sistema,montado;
spool off
EOF

grep -v "-" TablaBermudez | grep -v "rows" > BERMUDEZ.cvs
mail -s "Envio TablaBermudez" -a /home/alumno/scripts/BERMUDEZ.cvs maildechunche@gmail.com -c paeste95@gmail.com <<ESM
.
ESM
