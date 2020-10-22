#!/bin/sh
DIA=$(date +"%d/%m/%Y")
HORA=$(date +"%H:%M")
function menu1(){
    clear
    rm creaUsuario.sql
    # crear usuario, contraseña, cuota, tablespace, desbloqueada
    function menuUsuario(){
        read -p "Introduzca el nombre del usuario: " usuario
        read -p "Introduzca la contraseña del usuario: " contrasena 
        read -p "Introduzca la cuota para el usuario: " quota
        read -p "Introduzca el tablespace por defecto para el usuario: " tb
        # archivo sql
        echo "create user $usuario identified by $contrasena quota $quota on $tb default tablespace $tb account unlock;">>creaUsuario.sql 
        echo "grant connect, resource to $usuario;">>creaUsuario.sql
        echo "Hecho!"
        read -p "¿Desea crear otro usuario? " respuesta 
        case $respuesta in 
            S) menuUsuario;;
            s) menuUsuario;;
            N) echo "Vale, procedemos a realizar el trabajo";;
            n) echo "Vale, procedemos a realizar el trabajo";;
            *) echo "Opción inválida";;
        esac
    }
    # creacion de los usuarios
    function menuLanzarScript(){
sqlplus / as sysdba @creaUsuario.sql 
    }
    # lanzamiento de las funciones anteriores
    menuUsuario
    menuLanzarScript
    echo -e "\e[1;3m Trabajo terminado \e[0m"
}

function menu2(){
    # modificar usuario 
    rm modifica.sql
    read -p "Nombre del usuario: " usuario 
    read -p "¿Qué desea alterar? " objeto
    read -p "¿Qué modificamos? "  valor
    echo "alter user $usuario  ">>modifica.sql
    sqlplus / as sysdba @modifica.sql
}

function menu3(){
    rm borraUsuario.sql
    read -p "Nombre de usuario: " nombre
    echo "drop user $nombre cascade;">>borraUsuario.sql
    sqlplus / as sysdba @borraUsuario.sql
}

function menu4(){
    sqlplus / as sysdba<<EOF
SELECT username,
sid,
serial#
FROM v$session; 
EOF
}

function menu5(){
sqlplus / as sysdba <<EOF
SELECT s.username, s.program, s.logon_time
FROM v$session s, v$process p, sys.v_$sess_io si
WHERE s.paddr = p.addr(+)
AND si.sid(+) = s.sid
AND s.username = 'MEU_USUARIO';
EOF
}

function menu6(){
sqlplus / as sysdba<<EOF
select * from dba_tablespaces;
EOF
}

function menu7(){
    read -p "Ruta del tablespace en el sistema: " ruta 
    read -p "Tamaño del 'next': " size 
    read -p "Tamaño máximo de tablespace: " max
    echo "create tablespace $ruta
            autoextend on 
            next $size 
            maxsize $max
        ">>tablespace.sql
sqlplus / as sysdba @tablespace.sql
}

function menu8(){
    read -p "Nombre del usuario: " usuario 
    read -p "Nombre del tablespace" tb 
    read -p "Cuota a asignar a $usuario en el tablespace $tb :" s

    echo "alter user $usuario default tablespace $tb quota $s on $tb;">>asignartablespace.sql
sqlplus / as sysdba @asignartablespace.sql
}

function menu9(){
    read -p "Nombre del tablespace: " tablespace 
    read -p "Borramos datos(Y/N) " respuesta
    if [ $respuesta == 'Y' ];
    then 
        echo "drop tablespace $tablespace including contents cascade constraints;">>borratablespace.sql
    elif [ $respuesta == 'y' ];
        echo "drop tablespace $tablespace including contents cascade constraints;">>borratablespace.sql
    
    elif [ $respuesta == 'N' ];
        echo "drop tablespace $tablespace;">>borratablespace.sql
    elif [ $respuesta == 'n' ];
        echo "drop tablespace $tablespace;">>borratablespace.sql
    else
        echo "Opción no conocida."
    fi
sqlplus / as sysdba @borratablespace.sql
}

function menu10(){
    read -p "Nombre de la tabla: " tabla 
    read -p "Valor a introducir en la tabla $tabla : " valor 
    echo " 
        declare
        i NUMBER := 0; 
        begin
        while i <= true 
        loop 
        insert into $tabla values('$valor'); 
        end loop;
        end;
        /
        commit;
        ">>llenamitabla.sql 
    read -p "Nombre del usuario: " nombre 
    read -p "Contraseña de conexion: " contra 
    read -p "Nº de 4to de conexión: 10.1.35.XX " num
sqlplus $nombre/$contra@10.1.35.$num/asir @llenamitabla.sql 
}

function menu11(){
    read -p "Nombre de usuario: " nombre 
    read -p "Nombre de la tabla: " tabla 
    read -p "Valor a introducir: " valor
    read -p "Nº del 4to cuartero de conexión 10.1.35.XX " num
    echo "begin 
          for i in 1 .. 5000000 loop 
          insert into $tabla
          values($valor)
          loop end; 
          end;
          /
          commit;
        ">>llenaSutabla.sql
    sqlplus $nombre@10.1.35.$num/asir @llenaSutabla.sql

}

function menu12(){
    read -p "Nombre del role: " mirole
    read -p "Que objeto deseas modificar sus permisos: " objeto
    read -p "¿Qué privilegio añadimos? " priv 
    echo "create role $mirole;">>roles.sql
    echo "grant $priv on $objeto to $mirole;">>roles.sql
    
    read -p " Añadimos más privilegios (S/N): " respuesta
    while [ $respuesta != 'N' ] ; do 
        read -p "¿Qué privilegio añadimos? " priv 
        read -p "Sobre qué objeto: " objeto
        echo "grant $priv on $objeto to $mirole;">>roles.sql
    done
}

function menu13(){
    echo "      PERFILES        "
    echo "session per user => sesion por usuario."
    echo "cpu per user => cpu por usuario."
    echo "cpu per call => cpu por consulta."
    echo "connect time => tiempo de conexion. "
    echo "idle_time => tiempo de desconexion. "
    echo "logical reads per session => lecturas lógicas por sesion."
    echo "logical reads per call => lecturas lógicas por consultas."
    echo "private sga => SGA privada"
    echo "composite limit => limite compuesto"
    echo ""
    read -p "Nombre del perfil: " perfil 
    read -p "CPU para usuarios por sesion: " cpu1
    read -p "CPU. de consultas: " cpu2
    read -p "Tiempo de conexion: " conexion 
    read -p "Tiempo de desconexión antes de cerrar sesión: " desconecta 
    read -p "Lecturas por llamada: " lecturas 
    read -p "Composite limit: " composite
    echo " create profile $perfil limit 
        session_per_user    $cpu1
        cpu_per_session     $cpu2 
        connect_time        $conexion 
        idle_time           $desconecta 
        logical_reads_per_session DEFAULT
        logical_reads_per_call      $lecturas
        private_sga         15K
        composite_limit     $composite;
        ALTER SYSTEM SET resource_limit =TRUE scope = BOTH;
        " >>CREARPERFIL.sql
sqlplus / as sysdba @CREARPERFIL.sql
read -p "Nombre del usuario al que asignar el perfil: " nombre 
echo "alter user $nombre profile $perfil ">>asignaPerfil.sql
read -p "Añadimos más usuarios (S/N): " respuesta
while [  $respuesta != 'S' ]; do 
    read -p "Nombre del usuario al que asignar el perfil: " nombre 
    echo "alter user $nombre profile $perfil ">>asignaPerfil.sql
done 

sqlplus / as sysdba @asignaPerfil.sql
}

function menu14(){
sqlplus / as sysdba<<EOF
SELECT SESSION_ID,LOCK_TYPE, MODE_HELD  FROM dba_locks 
WHERE BLOCKING_OTHERS = 'Blocking';
EOF
}

function menu15(){
sqlplus / as sysdba<<EOF
SELECT * FROM DBA_BLOCKERS;
SELECT * FROM DBA_WAITERS;
EOF

read -p "Numero de ID de bloqueo: " idBloqueo
echo "SELECT SID,SERIAL# FROM V$SESSION WHERE SID = $idBloqueo;">>consultaBloqueo.sql
sqlplus / as sysdba @consultaBloqueo.sql

read -p "Introduzca nº de SID: " sid 
read -p "Introduzca nº de serial: " serial 
echo "ALTER SYSTEM KILL SESSION '$sid,$serial';">>mataSesion.sql 
sqlplus / as sysdba @mataSesion.sql
}

function menu16(){
sqlplus / as sysdba<<EOF
select oracle_username os_user_name, locked_mode, object_name, object_type from v$locked_object lo,dba_objects do where lo.object_id = do.object_id;
EOF
}

function menu17(){
sqlplus / as sysdba<<EOF
select SID,
serial#,
SID||’,’||serial# cadena,
username,
status
from v$session
where username like upper(‘&nombreUsuario%’)
/
prompt usuario a eliminar:
alter system kill session ‘cadena’
/
select SID,
serial#,
username,
status
from v$session
where username = upper(‘&nombreUsuario’)
EOF
}

function menu18(){
	clear
	echo -e "\e[4;2m --------------------------------------------	\e[0m"
	echo -e "\e[3;3m |           $DIA $HORA 		    |	\e[0m"
	echo -e "\e[2;2m |Saliendo del programa...Por favor, espere |	\e[0m"
	sleep 2	
	echo -e "\e[2;2m |  Fin del programa, programa finalizado.  |	\e[0m"
	echo -e "\e[5;2m |    Gracias por usar a pauchino.    :D    |	\e[0m"
	echo -e "\e[4;2m --------------------------------------------	\e[0m"
	sleep 5
	clear
	exit
}

function otromenu(){
    echo -e "\e[4;2m *****************************************************  \e[0m"
    echo -e "\e[4;2m *** OPCIÓN INVÁLIDA POR FAVOR VUELVA A INTENTARLO ***  \e[0m"
    echo -e "\e[4;2m *****************************************************  \e[0m"
    sleep 2
}

while true
do 
clear
echo ""
echo "------------------------------------------------------"
echo "--------> CONSULTAS DE LA BASE DE DATOS ORACLE<-------"
echo "------------------------------------------------------"
echo ""
echo "+-------------+"
echo "|  USUARIOS   |"
echo "+-------------+"
echo ""
echo "1 + CREAR USUARIO(S)"
echo "2 + MODIFICAR USUARIO"
echo "3 + BORRAR USUARIO"
echo "4 + VER USUARIOS CONECTADOS"
echo "5 + VER USUARIOS CONECTADOS (2)"
echo ""
echo "+-------------+"
echo "| TABLESPACES |"
echo "+-------------+"
echo ""
echo "6 + CONSULTAR LOS TABLESPACE POR DEFECTO"
echo "7 + CREAR UN TABLESPACE"
echo "8 + ASIGNAR UN TABLESPACE"
echo "9 + BORRAR TABLESPACE"
echo ""
echo "+--------------------+"
echo "| LLENAR TABLA DE BD |"
echo "+--------------------+"
echo "10 + Llenar tabla propia. "
echo "11 + Llenar tabla de otro usuario. "
echo ""
echo "+------------------------+"
echo "| CREAR ROLES Y PERFILES |"
echo "+------------------------+"
echo ""
echo "12 + CREAR ROLE CON PRIVILEGIO(S)"
echo "13 + CREAR PERFIL Y ASGINARLO"
echo ""
echo "+-----------------------------------+"
echo "| BLOQUEOS Y FIN DE SESION DE LA BD |"
echo "+-----------------------------------+"
echo ""
echo "14 + BLOQUEOS DE LA BASE DE DATOS."
echo "15 + DESCRIPCION DE USUARIOS BLOQUEADOS Y BLOQUEANTES"
echo "16 + SENTENCIA SQL BLOQUEADA"
echo "17 + TERMINAR SESION"
echo ""
echo "++===========================================================++"
echo "|| NOTA: Para escribir y guardar con tabulacion en  SQLPLUS: ||"
echo "|| rlwrap sqlplus / as sysdba.                               ||"
echo "++===========================================================++"
echo -e "\e[1;36m 18 +  Salir \e[0m"
read -p "Introduzca una opción: " opcion 
case $opcion in 
    1) menu1;;
    2) menu2;;
    3) menu3;;
    4) menu4;;
    5) menu5;;
    6) menu6;;
    7) menu7;;
    8) menu8;;
    9) menu9;;
    10) menu10;;
    11) menu11;;
    12) menu12;;
    13) menu13;;
    14) menu14;;
    15) menu15;;
    16) menu16;;
    17) menu17;;
    18) menu18;;
    *) otromenu;;
esac
done
