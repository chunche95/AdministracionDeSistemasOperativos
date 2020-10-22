#!/bin/bash

#################################################################################################
# Ejercicio 6 : Llena eltablespace CARRERAS.                                                    #
# Llena de datos el tablespace CARRERAS                                                         #
#    - Indica el metodo que utilizas para llenarlo de datos y qué mensaje de error aparece      #
#    - Amplıa el tablespace con un nuevo datafile para se puedan insertar mas datos.            #
#################################################################################################

# Llenamos el tablespace CARRERAS con un bucle. Nos conectamos con el USER: BERMUDEZ.
sqlplus BERMUDEZ/BERMUDEZ51@10.1.35.51/asir<<EOF
begin
for i in 1 .. 100000 loop
insert into resultados(valoracion) values('MALO');
loop end;
end;
/
COMMIT;
EOF

# Ampliacion del datafile de CARRERAS.
sqlplus / as sysdba<<EOF
alter tablespace carreras 
add datafile '/datos/carreras/MasCarreras.dbf'
size 2M
autoextend on
next 200k
maxsize 10M;
alter user BERMUDEZ quota 5M on carreras;
exit
EOF

# Llenamos de nuevo el tablespace con un bucle infinito.
sqlplus BERMUDEZ/BERMUDEZ51@10.1.35.51/asir<<EOF
declare
i NUMBER :=0;
begin
while i <= true
loop
insert into resultados(valoracion) values('MALO');
end loop;
end;
/
EOF
# Ampliación del tablespace carreras (sin crear otro dbf).
sqlplus / as sysdba<<EOF
alter tablespace carreras resize 1024M;
exit
EOF

# Llenado de tablespace con otra tabla nueva. 
sqlplus BERMUDEZ/BERMUDEZ51@10.1.35.51/asir<<EOF
drop table llenar;
create table llenar (id number, texto varchar(255))  tablespace carreras;
begin
for i in 1 .. 50000 loop 
insert into llenar (id,texto)
values(i,'lleno');
loop end;
end;
/
commit;
select * from llenar;
