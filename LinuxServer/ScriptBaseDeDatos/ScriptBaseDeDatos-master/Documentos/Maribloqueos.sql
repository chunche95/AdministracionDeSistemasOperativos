/*Usuarios conectados*/
select
  username,
  osuser,
  terminal
from
  sys.v_$session
where
  username is not null
order by
  username,
  osuser;

/*Usuarios conectados*/
SELECT s.username, s.program, s.logon_time
FROM sys.v_$session s, sys.v_$process p, sys.v_$sess_io si
WHERE s.paddr = p.addr(+)
AND si.sid(+) = s.sid
AND s.type = 'USER'; 

/*Bloqueos de la base de datos*/
select session_id "sid",SERIAL#  "Serial",
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
  SYS.V_$LOCKED_OBJECT A,
  SYS.ALL_OBJECTS B,
  SYS.V_$SESSION c
WHERE
  A.OBJECT_ID = B.OBJECT_ID AND
  C.SID = A.SESSION_ID
ORDER BY 1 ASC, 5 Desc;

/*Descripcion de usuarios bloqueantes y bloqueados*/
select s1.username || '@' || s1.machine
  || ' ( SID=' || s1.sid || ' )  is blocking '
  || s2.username || '@' || s2.machine || ' ( SID=' || s2.sid || ' ) ' AS blocking_status
  from v_$lock l1, v_$session s1, v_$lock l2, v_$session s2
  where s1.sid=l1.sid and s2.sid=l2.sid
  and l1.BLOCK=1 and l2.request > 0
  and l1.id1 = l2.id1
  and l2.id2 = l2.id2 ;

/*Sentencia SQL bloqueada (de un sid)*/
select s.sid, q.sql_text from v_$sqltext q, v_$session s
where q.address = s.sql_address
and s.sid = *ELSIDBLOQUEADO*
order by piece;

/*Sentencias SQL bloqueada*/
select s.sid, q.sql_text from v_$sqltext q, v_$session s
where q.address = s.sql_address
and s.sid in (
  select s2.sid
  from v_$lock l1, v_$session s1, v_$lock l2, v_$session s2
  where s1.sid=l1.sid and s2.sid=l2.sid
  and l1.BLOCK=1 and l2.request > 0
  and l1.id1 = l2.id1
  and l2.id2 = l2.id2 
)
order by piece;

/*Terminar una sesion*/
SELECT s.inst_id,
       s.sid,
       s.serial#,
       p.spid,
       s.username,
       s.program
FROM   gv_$session s
       JOIN gv_$process p ON p.addr = s.paddr AND p.inst_id = s.inst_id
WHERE  s.type != 'BACKGROUND';
ALTER SYSTEM KILL SESSION 'sid,serial#';

