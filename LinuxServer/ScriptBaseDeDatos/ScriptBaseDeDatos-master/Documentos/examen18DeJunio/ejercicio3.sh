#!/bin/bash

# Copia esquema.
# - Crea un directory de nombre backups_USUARIO que apunte a  /backups/backups_USUARIO.
# - Hacer un backup de las tablas del USUARIO.
# + En el nuevo usuario de nombre USUARIO_HHMM, siendo tu usuario, HH hora Y MM minutos actuales. EL nuevo usuario podrá iniciar sesión.
# + Si el usuario USUARIO_HHMM ya existe se informará del error y el error level del script será 1.
# + Usando las utilidades expdp e impdp
# - Dejar archivo en el directorio /home/usuario/backups.