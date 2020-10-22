#!/bin/bash

# Ver el role de 'connect' & 'resource'
clear

sqlplus / as sysdba<<EOF
select * from dba_roles order by role;
select * from dba_role_privs order by grantee;
select * from role_sys_privs where role='CONNECT';
select * from role_sys_privs where role='RESOURCE';
EOF

