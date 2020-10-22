#!/usr/bin/bash
ORACLE_HOME=/home/alumno/oracle-install-18c
ORACLE_SID=asir
PATH=$PATH:/home/alumno/oracle-install-18c/bin
export ORACLE_HOME
export ORACLE_SID

sqlplus -s / as sysdba <<EOF
set colsep ','    
set pagesize 11 
set trimspool on  
set headsep off   
set linesize 1000
spool karolDB.csv
SELECT sistema, avg(tamano), avg(usado), montado
FROM DF
GROUP BY
sistema,montado;
spool off
EOF

grep -v "-" karolDB.csv |grep -v "rows" > karol.csv

mail -s "Karol Dzierzak" -a /home/alumno/scripts/karol.csv alvarogonzalez.profesor@gmail.com alvaro@alvarogonzalez.no-ip.biz <<ESM
.
ESM
