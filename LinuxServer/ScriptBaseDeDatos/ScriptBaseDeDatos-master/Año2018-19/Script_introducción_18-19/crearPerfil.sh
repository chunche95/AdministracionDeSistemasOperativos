#!/bin/bash
#!/bin/bash

# Haz que el usuario LIMITADO
#  - Se quede sin sesión tras 1 minuto de inactividad
#  - Se quede sin sesión a los 2 minutos de conectarse, aunque no haya estado inactivo


clear

# Creo usuarios y perfil
sqlplus / as sysdba<<EOF
drop user LIMITADO cascade;
create user LIMITADO identified by LIMITADO;
alter user LIMITADO quota UNLIMITED on USERS;
grant connect, resource to LIMITADO;

create profile PERFILLIMITADO limit
SESSIONS_PER_USER          UNLIMITED 
CPU_PER_SESSION            UNLIMITED 
CPU_PER_CALL               3000 
CONNECT_TIME               1
IDLE_TIME                 300
LOGICAL_READS_PER_SESSION  DEFAULT 
LOGICAL_READS_PER_CALL     1000 
PRIVATE_SGA                15K
COMPOSITE_LIMIT            5000000; 

ALTER SYSTEM SET resource_limit = TRUE scope = BOTH;

alter user LIMITADO profile PERFILLIMITADO;
EOF

sqlplus LIMITADO/LIMITADO@10.1.35.51/asir<<EOF
create table LIMITE (time varchar (255));
insert into LIMITE values('5');
EOF


