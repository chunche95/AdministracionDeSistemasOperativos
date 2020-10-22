-- SELECT VERSION_NO FROM APEX_RELEASE;-- 
SELECT * FROM NLS_DATABASE_PARAMETERS;

-- USUARIO BLOQUEADO
DROP USER BLOQUEADO CASCADE;
create user bloqueado identified by b
quota unlimited on users
account unlock;

-- USUARIO BLOQUEANTE
DROP USER bloqueante CASCADE;
create user bloqueante identified by b
quota unlimited on users
account unlock;

-- PRIVILEGIOS 
grant connect, resource to bloqueado;
grant connect, resource to bloqueante;


-- ROL PARA USUARIOS NORMALES
DROP ROLE ROLBLOQUEOS;
create role ROLBLOQUEOS;
grant create any synonym to ROLBLOQUEOS;
grant update any table to ROLBLOQUEOS;
grant select any table to ROLBLOQUEOS;
grant select carreras to ROLBLOQUEOS;
-- ASIGNACION DEL ROL
grant ROLBLOQUEOS to bloqueado;
grant ROLBLOQUEOS to bloqueante;
grant all privileges to ROLBLOQUEOS;

-- creacion de rol con privilegios para BERMUDEZ
-- PRIVILEGIOS DE ADMINISTRACION PARA VER EL ESTADO DE LA BD
DROP ROLE CP;
create role CP;
GRANT SELECT ON SYS.V_$SESSION TO CP;
grant select on sys.v_$SQLTEXT to CP;
grant select on sys.v_$LOCKED_OBJECT to CP;
grant select on sys.v_$process to CP;
grant select on sys.v_$LOCK to CP;
grant select on sys.v_$SESS_IO to CP;
grant select on sys.gv_$session to CP;
grant select on sys.gv_$process to CP;
grant create any synonym to CP;
grant select on sys.dba_objects to cp;
grant select on dict to CP;
grant select, update on bloqueado.tabla to CP;
-- ASIGNACION 
GRANT CP TO BERMUDEZ;

DROP SYNONYM TABLAPRUEBAS;
create or replace PUBLIC synonym TABLA for BLOQUEADO.TABLA;


commit;

select * from dict where comments like '%lock%';
select * from v$lock;
select * from DBA_jobs_running;


-- QUIEN ESTA BLOQEUANDO
SELECT
decode(L.TYPE,'TM','TABLE','TX','Record(s)') TYPE_LOCK,
decode(L.REQUEST,0,'NO','YES') WAIT,
S.OSUSER OSUSER_LOCKER,
S.PROCESS PROCESS_LOCKER,
S.USERNAME DBUSER_LOCKER,
O.OBJECT_NAME OBJECT_NAME,
O.OBJECT_TYPE OBJECT_TYPE,
concat(' ',s.PROGRAM) PROGRAM,
O.OWNER OWNER
FROM v$lock l,dba_objects o,v$session s
WHERE l.ID1 = o.OBJECT_ID
AND s.SID =l.SID
AND l.TYPE in ('TM','TX');

-- Consulta tocha pero que saca informacion del usario bloqueado
select /*+ ordered
no_merge(L_WAITER)
no_merge(L_LOCKER) use_hash(L_LOCKER)
no_merge(S_WAITER) use_hash(S_WAITER)
no_merge(S_LOCKER) use_hash(S_LOCKER)
use_nl(O)
use_nl(U)
*/
/* first the table-level locks (TM) and mixed TM/TX TX/TM */
S_LOCKER.OSUSER OS_LOCKER,
S_LOCKER.USERNAME LOCKER_SCHEMA,
S_LOCKER.PROCESS LOCKER_PID,
S_WAITER.OSUSER OS_WAITER,
S_WAITER.USERNAME WAITER_SCHEMA,
S_WAITER.PROCESS WAITER_PID,
'Table lock (TM): '||U.NAME||'.'||O.NAME||
' - Mode held: '||
decode(L_LOCKER.LMODE,
0, 'None', /* same as Monitor */
1, 'Null', /* N */
2, 'Row-S (SS)', /* L */
3, 'Row-X (SX)', /* R */
4, 'Share', /* S */
5, 'S/Row-X (SSX)', /* C */
6, 'Exclusive', /* X */
'???: '||to_char(L_LOCKER.LMODE))||
' / Mode requested: '||
decode(L_WAITER.REQUEST,
0, 'None', /* same as Monitor */
1, 'Null', /* N */
2, 'Row-S (SS)', /* L */
3, 'Row-X (SX)', /* R */
4, 'Share', /* S */
5, 'S/Row-X (SSX)', /* C */
6, 'Exclusive', /* X */
'???: '||to_char(L_WAITER.REQUEST))
SQL_TEXT_WAITER
from
V$LOCK L_WAITER,
V$LOCK L_LOCKER,
V$SESSION S_WAITER,
V$SESSION S_LOCKER,
sys.OBJ$ O,
sys.USER$ U
where S_WAITER.SID = L_WAITER.SID
and L_WAITER.TYPE IN ('TM')
and S_LOCKER.sid = L_LOCKER.sid
and L_LOCKER.ID1 = L_WAITER.ID1
and L_WAITER.REQUEST > 0
and L_LOCKER.LMODE > 0
and L_WAITER.ADDR != L_LOCKER.ADDR
and L_WAITER.ID1 = O.OBJ#
and U.USER# = O.OWNER#
union
select /*+ ordered
no_merge(L_WAITER)
no_merge(L_LOCKER) use_hash(L_LOCKER)
no_merge(S_WAITER) use_hash(S_WAITER)
no_merge(S_LOCKER) use_hash(S_LOCKER)
no_merge(L1_WAITER) use_hash(L1_WAITER)
no_merge(O) use_hash(O)
*/
/* now the (usual) row-locks TX */
S_LOCKER.OSUSER OS_LOCKER,
S_LOCKER.USERNAME LOCKER_SCHEMA,
S_LOCKER.PROCESS LOCK_PID,
S_WAITER.OSUSER OS_WAITER,
S_WAITER.USERNAME WAITER_SCHEMA,
S_WAITER.PROCESS WAITER_PID,
'TX: '||O.SQL_TEXT SQL_TEXT_WAITER
from
V$LOCK L_WAITER,
V$LOCK L_LOCKER,
V$SESSION S_WAITER,
V$SESSION S_LOCKER,
V$_LOCK L1_WAITER,
V$OPEN_CURSOR O
where S_WAITER.SID = L_WAITER.SID
and L_WAITER.TYPE IN ('TX')
and S_LOCKER.sid = L_LOCKER.sid
and L_LOCKER.ID1 = L_WAITER.ID1
and L_WAITER.REQUEST > 0
and L_LOCKER.LMODE > 0
and L_WAITER.ADDR != L_LOCKER.ADDR
and L1_WAITER.LADDR = L_WAITER.ADDR
and L1_WAITER.KADDR = L_WAITER.KADDR
and L1_WAITER.SADDR = O.SADDR
and O.HASH_VALUE = S_WAITER.SQL_HASH_VALUE
;


/* VER EL SID DE LOS USUARIOS CONECTADOS */

select username,osuser, terminal from v$session where username is not null order by username,osuser;
select s.username, s.sid, l.type, l.lmode, l.request from v$lock l, v$session s where l.sid = s.sid and username not like 'null';

/* VER USUARIOS BLOQUEADOS Y BLOQUEANTE DE LA BD */
select oracle_username os_user_name, locked_mode, object_name, object_type from v$locked_object lo,dba_objects do where lo.object_id = do.object_id;


-- EN NUMERO DE BLOCKING_SESSION ES EL SID DEL USUARIO QUE ESTA BLOQUEANDO LA BASE DE DATOS
select  S.SID, S.SERIAL#, s.username, s.program, s.logon_time, S.PROCESS, S.PROGRAM, BLOCKING_SESSION, BLOCKING_INSTANCE
from v$session s, v$process p, v$sess_io si
where s.paddr = p.addr and 
si.sid = s.sid and
s.type = 'USER';


-- BLOQUEOS DE LA BASE DE DATOS.
select 
    session_id "sid",SERIAL#  "Serial",
    substr(object_name,1,20) "Object",
    substr(os_user_name,1,10) "Terminal",
    substr(oracle_username,1,10) "Locker",
    nvl(lockwait,'active') "Wait",
    decode(locked_mode,
        2, 'row share',
        3, 'row exclusive',
        4, 'share',
        5, 'share row exclusive',
        6, 'exclusive',  'unknown') "Lockmode",
    OBJECT_TYPE "Type"
FROM 
    SYS.V_$LOCKED_OBJECT A,SYS.ALL_OBJECTS B,SYS.V_$SESSION c
WHERE 
    A.OBJECT_ID = B.OBJECT_ID AND 
    C.SID = A.SESSION_ID 
ORDER BY 1 ASC, 5 Desc;


--- SENTENCIA SQL BLOQUEADA DE UN SID --> SENTENCIA QUE SE DESEA REALIZAR 
SELECT S.SID, Q.SQL_TEXT 
FROM V$SQLTEXT Q, V$SESSION S
WHERE Q.ADDRESS = S.SQL_ADDRESS 
AND S.SID = 64
ORDER BY PIECE;

-- sentencias sql bloqueadas --> USUARIO QUE ESTA ESPERANDO A TENER ACCESO A LA BD
select 
    s.sid, S.USERNAME, S.PROCESS, q.sql_text, LOGON_TIME,STATE, BLOCKING_SESSION
from
    v_$sqltext q, v_$session s
where
    q.address = s.sql_address 
and s.sid 
in (select s2.sid from v_$lock l1, v_$session s1, v_$lock l2, v_$session s2
    where s1.sid=l1.sid 
    and s2.sid=l2.sid 
    and l1.BLOCK=1
    and l2.request > 0
    and l1.id1 = l2.id1
    and l2.id2 = l2.id2)
order by piece;

-- TERMINAR UNA SESION

SELECT
    s.inst_id,
    s.sid,
    s.serial#,
    p.spid,
    s.username,
    S.PROCESS,
    P.PROGRAM,
    S.BLOCKING_INSTANCE,
    S.BLOCKING_SESSION,
    P3TEXT,
    s.program
FROM
    gv_$session s
JOIN
    gv_$process p
ON
    p.addr = s.paddr
AND
    p.inst_id = s.inst_id
WHERE
    s.type != 'BACKGROUND';

-- MATAR LA SESION DEL USUARIO QUE ESTA BLOQUEANDO LA BASE DE DATOS
ALTER SYSTEM KILL SESSION '89, 51514';