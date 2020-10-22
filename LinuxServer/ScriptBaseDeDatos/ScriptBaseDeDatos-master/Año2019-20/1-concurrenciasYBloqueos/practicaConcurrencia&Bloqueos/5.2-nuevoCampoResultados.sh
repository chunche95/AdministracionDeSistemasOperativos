#!/bin/bash

# Haz que puedan escribir en un campo de la tabla RESULTADOS:
# Crea un nuevo campo en la tabla RESULTADOS:VALORACION, de tipoVARCHAR(20).
# Tendra como ́unicos valores posibles MALO,ACEPTABLE,BUENO y MUY BUENO.
# Da permisos al resto de usuarios para poder leer y actualizar este campo, con una orden GRANT
#      • http://stackoverflow.com/questions/14462353/grant-alter-on-only-one-column-in-table
# - Pide a algun otro compañero que compruebe que funciona
# - Pide al profesor que compruebe que funciona.


# Modifico mi tabla RESULTADOS para que puedan hacer cambios.
sqlplus BERMUDEZ/BERMUDEZ51@10.1.35.51/asir<<EOF
alter table RESULTADOS add VALORACION varchar(20) default 'BUENO' not null check (valoracion in ('MALO', 'ACEPTABLE', 'BUENO', 'MUY BUENO' ));
EOF

# LECTURATABLAS -> rol creado con anterioridad.
# Le añado el privilegio de UPDATE(VALORACION) para la tabla resultados.
# -- alter role LECTURATABLAS add update; => No creo  que funcione pero por ahi lo ví. 
sqlplus / as sysdba<<EOF
grant update(valoracion) on BERMUDEZ.RESULTADOS to LECTURATABLAS;
EOF
sleep 5
clear
echo "Cambiando campo VALORACION - Modo pruebas" 
sleep 5
# PRUEBAS:
# - Usuario que realiza un cambio en valoracion=aceptable.
sqlplus PRUEBAS/PRUEBAS@10.1.35.51/asir<<EOF
update RESULTADOS set valoracion='ACEPTABLE';
commit;
exit
EOF
sleep 5
clear
echo "Confirmando cambios - Modo pruebas"
sleep 5
# - Usuario que verifica el cambio del campo valoracion.
sqlplus UTRERO/UTRERO@10.1.35.51/asir<<EOF
select * from resultados;
exit
EOF
echo "Confirmando cambios - Modo pruebas"
sleep 5
sqlplus PROFESOR/PROFESOR@10.1.35.51/asir<<EOF
update RESULTADOS set valoracion='MALO';
commit;
select * from resultados;
exit
EOF
echo "Pruebas finalizadas - Modo pruebas"