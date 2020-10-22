#!/bin/bash

#################################################################
# ----- Ejercicio 2 : Crear usuarios para tus compañeros. ----- #
#                                                               #
# Crea un usuario para tı, uno para cada uno de tus compañeros, #
# y uno para el profesor. La contrase ̃nainicial ser ́a la misma  #
# que el nombre, excepto en tu usuario que deber ́ıa ser una     #
# contraseña secreta.                                           #
# ------------------------------------------------------------- #
# Tu  propio  usuario  tendra comotablespace por defecto USERS, #
# y los demasPARAOTROS. Los usuariosnecesitan poder conectarse a#
# la base de datos y crear tablas en sutablespacepor defecto.   #
# Los usuarios de los otros alumnos tendran una cuota de 10 MB  #
# en PARAOTROS, y no podran escribir nada en USERS.             #
# |                                                             #
# + El resto de usuarios podran conectarse con sqlplus          #
# | USUARIO/USUARIO@HOST:1521/SID                               #
# +Pide a algunos compañeros que comprueben su usuario.         #
# +Pide al profesor que compruebe su usuario.                   #
#################################################################

#################################################
# => Creación del script SQL para los usuarios. #
#################################################

# El resto de usuarios.
rm crear.sql
for i in `cat lista`;
do 
  echo "create user $i identified by $i quota 10M on paraotros default tablespace paraotros;">>crear.sql
  echo "user and password ===> OK!"
  echo "grant connect, resource to $i;">>crear.sql
  echo "grant connect, resource to BERMUDEZ;">>crear.sql
  echo "Privileges ===> OK!"
done
# Mi usuario BERMUDEZ
echo "create user BERMUDEZ identified by BERMUDEZ51 default tablespace USERS quota unlimited on Users;">>crear.sql
echo "user and password ===> OK!"
echo "grant connect, resource to BERMUDEZ;">>crear.sql
echo "Privileges ===> OK!"
# Creo los usuarios nuevos lanzando el script de SQL
sqlplus / as sysdba @crear.sql
