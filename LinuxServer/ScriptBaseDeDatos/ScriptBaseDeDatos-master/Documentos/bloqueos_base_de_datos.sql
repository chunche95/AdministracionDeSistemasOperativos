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
