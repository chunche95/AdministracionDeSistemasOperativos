#!/bin/bash

# Compartir datos
# Carga en el usuario  el script de base de datos que proporviona el servidor.
# Crea un script que:
# - Si no recibe exactamente 1 parámetro, mostrará que necesita un parámetro
# - Creará un usuario con el nombre USUARIO.parámetro en Oracle. El nuevo usuario podrá conectarse y crear tablas, con la contraseña del USUARIO.
# - Si ya existe el usuario USUARIO.parámetro, informará del error y acabarña con un error level de 1.
# - USUARIO.parámetro podra leer filas de USUARIO.multas y podra modificar el campo USUARIO.multas.Importe.
# - Los permisos los recibirá a través de un rol.
