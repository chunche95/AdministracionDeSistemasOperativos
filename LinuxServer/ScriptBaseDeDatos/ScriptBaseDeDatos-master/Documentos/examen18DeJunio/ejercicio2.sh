#!/bin/bash

# Fin de sesiones bloqueadas
# Realizar script que al ser llamado:
# - Invocado SIN parámetros, hará un listado de las sesiones de USUARIO  bloqueadas en la instancia.
# NO SALDRAN  LOS DE OTROS USUARIO BLOQUEADOS. [SID BLOQUEADO| SID BLOQUEANTE| SENTENCIA SQL BLOQUEADA]
# - Invocado con el parámetro 'kill' intentará eliminar todas las sesiones bloqueantes con el comando kill de Linux.
# - Realizar demostración.