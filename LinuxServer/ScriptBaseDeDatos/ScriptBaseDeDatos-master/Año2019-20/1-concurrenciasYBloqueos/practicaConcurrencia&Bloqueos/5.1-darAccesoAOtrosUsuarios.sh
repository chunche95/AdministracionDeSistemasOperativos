#!/bin/bash

# Ejercicio 5: Dar acceso a otros usuarios a un campo de tus tablas
# Tras la importacion, haz que las tablas puedan ser leidas por el resto de usuarios:
# Haz que el resto de usuarios pueda realizar SELECT sobre tus tablas. 
# Crea sinonimos en todos los usuarios para que puedan acceder a tus tablas sin problemas
#      • Por ejemplo, el usuario profesor deberıa poder ejecutar
#             SELECT * FROM CIRCUITOS;
#         Puesto que habras creado un sinonimo del tipo:
#             CREATE PUBLIC SYNONYM CIRCUITOS FOR MIUSUARIO.CIRCUITOS;

sqlplus / as sysdba<<EOF

create or replace public synonym escuderias for BERMUDEZ.escuderias; 
create or replace public synonym pilotos for BERMUDEZ.pilotos;      
create or replace public synonym prototipos for BERMUDEZ.prototipos; 
create or replace public synonym carreras for BERMUDEZ.carreras;     
create or replace public synonym resultados for BERMUDEZ.resultados; 
create or replace public synonym circuitos for BERMUDEZ.circuitos;   

drop role LECTURATABLAS;                                             
create role LECTURATABLAS;                                           
                                                                  
grant select on BERMUDEZ.escuderias to LECTURATABLAS;                
grant select on BERMUDEZ.pilotos to LECTURATABLAS;                   
grant select on BERMUDEZ.prototipos to LECTURATABLAS;                
grant select on BERMUDEZ.carreras to LECTURATABLAS;                 
grant select on BERMUDEZ.resultados to LECTURATABLAS;                
grant select on BERMUDEZ.circuitos to LECTURATABLAS;                 
exit
EOF
rm privilegiosOtrosUsuarios.sql
for i in `cat lista`;
do 
  echo "grant LECTURATABLAS to $i;">>privilegiosOtrosUsuarios.sql
  echo "PRIVILEGIOS OTORGADOS A $i"
  sleep 1
  clear
  echo "Script terminado"
done

# Lanzo el script 'privilegiosOtrosUsuarios.sql' de SQL con sys en SQLPLUS
sqlplus / as sysdba @privilegiosOtrosUsuarios.sql
