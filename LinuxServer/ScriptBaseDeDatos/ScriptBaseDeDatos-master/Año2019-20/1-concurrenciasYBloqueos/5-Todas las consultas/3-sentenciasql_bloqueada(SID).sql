select s.sid, q.sql_text from v_$sqltext q, v_$session s
where q.address = s.sql_address
and s.sid = *ELSIDBLOQUEADO*
order by piece;
