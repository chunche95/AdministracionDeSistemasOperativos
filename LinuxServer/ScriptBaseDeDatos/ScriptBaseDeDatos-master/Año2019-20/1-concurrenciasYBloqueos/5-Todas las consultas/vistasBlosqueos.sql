
/* EJECUTRAMOS CON SYS */ 
GRANT SELECT, INSERT, UPDATE, DELETE ON casa.tabla1 TO casa;
GRANT SELECT, INSERT, UPDATE, DELETE ON casa.tabla2 TO casa;
commit;

SELECT SESSION_ID,LOCK_TYPE, MODE_HELD  FROM dba_locks 
WHERE BLOCKING_OTHERS = 'Blocking';

SELECT * FROM DBA_WAITERS;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT * FROM TEST;



SELECT USERNAME,SID,SERIAL# FROM V$SESSION WHERE SID =8;


SELECT * FROM V$SESSION;

select sid, type, lmode, request from v$lock;


/* Ver los bloqueos de mi BD */

SELECT inst_id, DECODE(request, 0,'Bloquea: ','Espera: ')||sid SID, id1, id2, lmode, request, type, ctime/60 "minutos"
 FROM GV$LOCK
 WHERE (id1, id2, type) IN (SELECT id1, id2, type FROM GV$LOCK WHERE request > 0)
 ORDER BY id1, request;
 
 /*Obtenemos características de la sesión. */
 
 select sid,serial#, username, status, sql_hash_value,PREV_HASH_VALUE,machine from v$session where sid in (8);