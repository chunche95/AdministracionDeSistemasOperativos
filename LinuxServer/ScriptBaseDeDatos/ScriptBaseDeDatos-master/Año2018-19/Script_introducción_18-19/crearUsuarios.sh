#!/bin/sh

sqlpus / as sysdba<<EOF
drop user pau;
create user pau identified pau1
DEFAULT TABLESPACE MITABLESPACE
QUOTA 1200k ON MITABLESPACE
ACCOUNT UNLOCK;
exit
EOF
