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
