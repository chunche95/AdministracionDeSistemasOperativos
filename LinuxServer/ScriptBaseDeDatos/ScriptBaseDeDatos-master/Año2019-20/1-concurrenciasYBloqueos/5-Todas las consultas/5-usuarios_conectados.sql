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
